import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapMobileCSObe extends StatefulWidget {
  final String courseName;
  const MapMobileCSObe({super.key, required this.courseName});

  @override
  _MapMobileCSObeState createState() => _MapMobileCSObeState();
}

class _MapMobileCSObeState extends State<MapMobileCSObe> {
  String? selectedPLO = 'Select';
  String? selectdomain = 'Select';
  String? selectlevel = 'Select';
  final TextEditingController cloTextController = TextEditingController();
  final TextEditingController objectivesTextController =
      TextEditingController();
  List<Map<String, dynamic>> courseObjectives = [];
  List<String> ploValues = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPLOValues();
    _fetchObjectives();
  }

  Future<void> _fetchPLOValues() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('csplos').get();

      setState(() {
        ploValues = snapshot.docs.map((doc) => doc['Sr#'].toString()).toList();
        _isLoading = false;
      });
    } catch (e) {
      _showAlertDialog('Failed to fetch PLO values', 'Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchObjectives() async {
    setState(() {
      _isLoading = true;
    });
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('cs_course_objectives')
          .where('courseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
        courseObjectives = snapshot.docs
            .map((doc) => {
                  'id': doc.id,
                  'courseName': doc['courseName'],
                  'CLO': doc['CLO'],
                  'PLO': doc['PLO'],
                  'Domain': doc['Domain'],
                  'Level': doc['Level'],
                  'objectivesText': doc['objectivesText'],
                })
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      _showAlertDialog('Failed to fetch objectives', 'Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addObjective() async {
    if (objectivesTextController.text.isNotEmpty &&
        cloTextController.text.isNotEmpty &&
        selectdomain != 'Select' &&
        selectlevel != 'Select' &&
        selectedPLO != 'Select') {
      try {
        await FirebaseFirestore.instance
            .collection('cs_course_objectives')
            .add({
          'courseName': widget.courseName,
          'CLO': cloTextController.text,
          'PLO': selectedPLO,
          'objectivesText': objectivesTextController.text,
          'Domain': selectdomain,
          'Level': selectlevel,
        });

        _showAlertDialog('Success', 'Objective added successfully');

        // Clear the form fields
        setState(() {
          selectedPLO = 'Select';
          selectdomain = 'Select';
          selectlevel = 'Select';
          cloTextController.clear();
          objectivesTextController.clear();
        });

        // Fetch updated objectives
        _fetchObjectives();
      } catch (e) {
        _showAlertDialog('Failed to add objective', 'Error: $e');
      }
    } else {
      _showAlertDialog('Failed', 'Please fill all fields');
    }
  }

  void _deleteObjective(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('cs_course_objectives')
          .doc(id)
          .delete();

      _showAlertDialog('Success', 'Objective deleted successfully');

      // Fetch updated objectives
      _fetchObjectives();
    } catch (e) {
      _showAlertDialog('Failed to delete objective', 'Error: $e');
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> _getLevelOptions(String? domain) {
    switch (domain) {
      case 'Cognitive':
        return [
          'Select',
          'C1-Knowledge',
          'C2-Comprehension',
          'C3-Application',
          'C4-Analysis',
          'C5-Synthesis',
          'C6-Evaluation'
        ];
      case 'Psychomotive':
        return [
          'Select',
          'P1-Receiving',
          'P2-Responding',
          'P3-Valuing',
          'P4-Organization',
          'P5-Characterization'
        ];
      case 'Affective':
        return [
          'Select',
          'A1-Perception',
          'A2-Set',
          'A3-Guided Response',
          'A5-Mechanism',
          'A6-Complex Overt Response',
          'A7-Adaptation',
          'A8-Origination'
        ];
      default:
        return ['Select'];
    }
  }

  void _quickViewObjective(Map<String, dynamic> objective) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Objective Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Course Name: ${objective['courseName'] ?? ''}'),
              Text('CLO: ${objective['CLO'] ?? ''}'),
              Text('PLO: ${objective['PLO'] ?? ''}'),
              Text('Domain: ${objective['Domain'] ?? ''}'),
              Text('Level: ${objective['Level'] ?? ''}'),
              Text('Description: ${objective['objectivesText'] ?? ''}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    cloTextController.dispose();
    objectivesTextController.dispose();
    super.dispose();
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
          title:
              const Text("Course CLOs", style: TextStyle(color: Colors.white)),
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
                  scrollDirection: Axis.vertical,
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
                                'Clo`s',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 170,
                                child: TextFormField(
                                  controller: cloTextController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter CLO',
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
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    cursorColor: Colors.blue,
                                    maxLines: 1,
                                    controller: objectivesTextController,
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      hintText: "Description",
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
                                'Plo`s',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 100,
                                child: DropdownButton<String>(
                                  value: selectedPLO,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: ['Select', ...ploValues]
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedPLO = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Domain',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButton<String>(
                                  value: selectdomain,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: [
                                    'Select',
                                    'Cognitive',
                                    'Psychomotive',
                                    'Affective'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectdomain = newValue;
                                      selectlevel = 'Select';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Level',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 260,
                                child: DropdownButton<String>(
                                  value: selectlevel,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: _getLevelOptions(selectdomain)
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectlevel = newValue;
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
                              onPressed: _addObjective,
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
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 1000,
                    height: 538,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 1100,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.3 / 2,
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.shade100,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : DataTable(
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
                                          'CLO',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Description',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'PLO',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Domain',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Level',
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
                                    rows: courseObjectives.map((objective) {
                                      return DataRow(
                                        cells: [
                                          DataCell(SizedBox(
                                            width: 150,
                                            child: Tooltip(
                                              message: objective['courseName'],
                                              child: Text(
                                                objective['courseName'] ?? '',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )),
                                          DataCell(
                                              Text(objective['CLO'] ?? '')),
                                          DataCell(
                                            SizedBox(
                                              width: 200,
                                              child: Tooltip(
                                                message:
                                                    objective['objectivesText'],
                                                child: Text(
                                                  objective['objectivesText'] ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                              Text(objective['PLO'] ?? '')),
                                          DataCell(
                                              Text(objective['Domain'] ?? '')),
                                          DataCell(
                                              Text(objective['Level'] ?? '')),
                                          DataCell(
                                            PopupMenuButton<String>(
                                              onSelected: (value) {
                                                if (value == 'delete') {
                                                  _deleteObjective(
                                                      objective['id']);
                                                } else if (value ==
                                                    'quickView') {
                                                  _quickViewObjective(
                                                      objective);
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  const PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text('Delete'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'quickView',
                                                    child: Text('Quick View'),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
