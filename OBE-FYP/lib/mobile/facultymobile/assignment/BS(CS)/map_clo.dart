import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CSMapMobileObeAssignment extends StatefulWidget {
  final String courseName;
  const CSMapMobileObeAssignment({super.key, required this.courseName});

  @override
  _CSMapMobileObeAssignmentState createState() =>
      _CSMapMobileObeAssignmentState();
}

class _CSMapMobileObeAssignmentState extends State<CSMapMobileObeAssignment> {
  final TextEditingController assignmenttextcontroller =
      TextEditingController();
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController marksTextController = TextEditingController();
  String? selectedCLO = "Select";
  String? selectedComplexity = "Select";
  List<String> cloList = ["Select"];
  List<Map<String, dynamic>> assignmentList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCLOsAndAssignments();
  }

  Future<void> fetchCLOsAndAssignments() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch CLOs from Firestore
      final cloSnapshot = await FirebaseFirestore.instance
          .collection('cs_course_objectives')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      final cloDocs = cloSnapshot.docs;
      if (cloDocs.isNotEmpty) {
        cloList.addAll(cloDocs.map((doc) => doc['CLO'].toString()).toList());
      }

      // Fetch existing assignments
      final assignmentSnapshot = await FirebaseFirestore.instance
          .collection('cs_assignment')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
        assignmentList =
            assignmentSnapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      showAlert('Error', 'Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addAssignment() async {
    if (assignmenttextcontroller.text.isEmpty ||
        questionTextController.text.isEmpty ||
        marksTextController.text.isEmpty ||
        selectedCLO == null ||
        selectedComplexity == null ||
        selectedCLO == "Select" ||
        selectedComplexity == "Select") {
      showAlert(
          'Error', 'All fields must be filled and dropdowns must be selected');
      return;
    }

    final assignmentData = {
      'courseName': widget.courseName,
      'assignment': assignmenttextcontroller.text,
      'question': questionTextController.text,
      'CLO': selectedCLO,
      'totalMarks': marksTextController.text,
      'complexity': selectedComplexity,
    };

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('cs_assignment')
          .add(assignmentData);
      showAlert('Success', 'Assignment added successfully');

      // Reset fields
      assignmenttextcontroller.clear();
      questionTextController.clear();
      marksTextController.clear();
      setState(() {
        selectedCLO = "Select";
        selectedComplexity = "Select";
        assignmentList.add(assignmentData);
      });
    } catch (e) {
      showAlert('Error', 'Failed to add assignment: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteAssignment(String docId) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('cs_assignment')
          .doc(docId)
          .delete();
      showAlert('Success', 'Assignment deleted successfully');
      setState(() {
        assignmentList.removeWhere((assignment) => assignment['id'] == docId);
      });
    } catch (e) {
      showAlert('Error', 'Failed to delete assignment: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void quickViewAssignment(Map<String, dynamic> assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick View'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Course Name: ${assignment['courseName']}'),
              Text('Assignment: ${assignment['assignment']}'),
              Text('Question: ${assignment['question']}'),
              Text('CLO: ${assignment['CLO']}'),
              Text('Total Marks: ${assignment['totalMarks']}'),
              Text('Complexity: ${assignment['complexity']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Assignments CLOs",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
          child: Column(
            children: [
              Container(
                width: 1000,
                height: 120,
                color: Colors.lightBlueAccent.shade100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Course Name',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 250,
                              child: DropdownButton<String>(
                                value: widget.courseName,
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: [
                                  DropdownMenuItem(
                                      value: widget.courseName,
                                      child: Text(widget.courseName)),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Assignment',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 170,
                              child: TextFormField(
                                controller: assignmenttextcontroller,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Assignment no',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Question',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: TextFormField(
                                  cursorColor: Colors.blue,
                                  maxLines: 1,
                                  controller: questionTextController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    hintText: "Question",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Clo`s',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                                width: 100,
                                child: DropdownButton<String>(
                                  value: selectedCLO,
                                  items: cloList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCLO = newValue;
                                    });
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Marks',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 170,
                              child: TextFormField(
                                controller: marksTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Marks',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Complexity',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 260,
                              child: DropdownButton<String>(
                                value: selectedComplexity,
                                items: ['Select', 'Low', 'Medium', 'High']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedComplexity = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                          ),
                          child: ElevatedButton.icon(
                            onPressed: addAssignment,
                            icon: const Icon(Icons.add),
                            label: const Text('Add'),
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0), // Custom border radius
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 1000,
                height: 538,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.shade100,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: DataTable(
                        columnSpacing: 80,
                        dataRowMinHeight: 2,
                        dataRowMaxHeight: 50,
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Course Name',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Assignment',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Question',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Clo`s',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Total Marks',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Complexity',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ],
                        rows: assignmentList.map((assignment) {
                          return DataRow(cells: [
                            DataCell(Text(assignment['courseName'] ?? '')),
                            DataCell(Text(assignment['assignment'] ?? '')),
                            DataCell(Text(assignment['question'] ?? '')),
                            DataCell(Text(assignment['CLO'] ?? '')),
                            DataCell(Text(assignment['totalMarks'] ?? '')),
                            DataCell(Text(assignment['complexity'] ?? '')),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        deleteAssignment(assignment['id']),
                                    icon: const Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        quickViewAssignment(assignment),
                                    icon: const Icon(Icons.remove_red_eye),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
