import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components.dart';

class SEMapObeQuiz extends StatefulWidget {
  final String courseName;
  const SEMapObeQuiz({super.key, required this.courseName});

  @override
  _SEMapObeQuizState createState() => _SEMapObeQuizState();
}

class _SEMapObeQuizState extends State<SEMapObeQuiz> {
  final TextEditingController quiztextcontroller = TextEditingController();
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController marksTextController = TextEditingController();
  // String? selectedCLO = "Select";
  String? selectedComplexity = "Select";
  // List<String> cloList = ["Select"];
  List<Map<String, dynamic>> quizList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCLOsAndQuiz();
  }

  Future<void> fetchCLOsAndQuiz() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Fetch CLOs from Firestore
      final cloSnapshot = await FirebaseFirestore.instance
          .collection('course_objectives')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      // final cloDocs = cloSnapshot.docs;
      // if (cloDocs.isNotEmpty) {
      //   cloList.addAll(cloDocs.map((doc) => doc['CLO'].toString()).toList());
      // }

      // Fetch existing assignments
      final quizSnapshot = await FirebaseFirestore.instance
          .collection('se_quiz')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
        quizList = quizSnapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      showAlert('Error', 'Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addQuiz() async {
    if (quiztextcontroller.text.isEmpty ||
        questionTextController.text.isEmpty ||
        marksTextController.text.isEmpty ||
        // selectedCLO == null ||
        selectedComplexity == null ||
        // selectedCLO == "Select" ||
        selectedComplexity == "Select") {
      showAlert(
          'Error', 'All fields must be filled and dropdowns must be selected');
      return;
    }

    final quizData = {
      'courseName': widget.courseName,
      'assignment': quiztextcontroller.text,
      'question': questionTextController.text,
      // 'CLO': selectedCLO,
      'totalMarks': marksTextController.text,
      'complexity': selectedComplexity,
    };

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('se_quiz').add(quizData);
      showAlert('Success', 'Quiz added successfully');

      // Reset fields
      quiztextcontroller.clear();
      questionTextController.clear();
      marksTextController.clear();
      setState(() {
        // selectedCLO = "Select";
        selectedComplexity = "Select";
        quizList.add(quizData);
      });
    } catch (e) {
      showAlert('Error', 'Failed to add quiz: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteQuiz(String docId) async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('se_quiz')
          .doc(docId)
          .delete();
      showAlert('Success', 'Quiz deleted successfully');
      setState(() {
        quizList.removeWhere((quiz) => quiz['id'] == docId);
      });
    } catch (e) {
      showAlert('Error', 'Failed to delete quiz: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void quickViewQuiz(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick View'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Course Name: ${quiz['courseName']}'),
              Text('Quiz: ${quiz['assignment']}'),
              Text('Question: ${quiz['question']}'),
              // Text('CLO: ${quiz['CLO']}'),
              Text('Total Marks: ${quiz['totalMarks']}'),
              Text('Complexity: ${quiz['complexity']}'),
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
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 150,
                height: double.infinity,
                color: Colors.blueAccent.shade700,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 1386,
                height: 70,
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 1387,
                height: 150,
                color: Colors.blueAccent.shade700,
              ),
            ),
            Positioned(
              right: 0,
              top: 69,
              bottom: 150,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Positioned(
                top: 50,
                left: 50,
                right: 50,
                bottom: 50,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white60,
                  ),
                  //use expanded widget to divide the menus drawer and body content............
                  child: Row(
                    children: [
                      //this for drawer..........................
                      const Expanded(
                        child: FacultyDrawer(),
                      ),
                      //this for body...............................
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade50,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomRight: Radius.circular(24))),
                          child: const Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  child: FacultyHeader(name: "SE Quiz")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.235,
              top: 120,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
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
                              'Quiz',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 170,
                              child: TextFormField(
                                controller: quiztextcontroller,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Quiz no',
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
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const Text(
                        //       'Clo`s',
                        //       style: TextStyle(fontSize: 18),
                        //     ),
                        //     SizedBox(
                        //         width: 100,
                        //         child: DropdownButton<String>(
                        //           value: selectedCLO,
                        //           items: cloList.map((String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(value),
                        //             );
                        //           }).toList(),
                        //           onChanged: (String? newValue) {
                        //             setState(() {
                        //               selectedCLO = newValue;
                        //             });
                        //           },
                        //         )),
                        //   ],
                        // ),
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
                            onPressed: addQuiz,
                            icon: const Icon(Icons.add),
                            // Icon you want to display
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
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.235,
              top: 300,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
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
                              'Quiz',
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
                          // DataColumn(
                          //   label: Text(
                          //     'Clo`s',
                          //     style: TextStyle(
                          //       color: Colors.blue,
                          //       fontSize: 23,
                          //     ),
                          //   ),
                          // ),
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
                        rows: quizList.map((quiz) {
                          return DataRow(cells: [
                            DataCell(Text(quiz['courseName'] ?? '')),
                            DataCell(Text(quiz['assignment'] ?? '')),
                            DataCell(Text(quiz['question'] ?? '')),
                            // DataCell(Text(quiz['CLO'] ?? '')),
                            DataCell(Text(quiz['totalMarks'] ?? '')),
                            DataCell(Text(quiz['complexity'] ?? '')),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => deleteQuiz(quiz['id']),
                                    icon: const Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () => quickViewQuiz(quiz),
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
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
