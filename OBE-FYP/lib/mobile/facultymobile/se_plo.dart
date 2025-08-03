import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SEMobileplos extends StatefulWidget {
  const SEMobileplos({super.key});
  @override
  _SEMobileplosState createState() => _SEMobileplosState();
}

class _SEMobileplosState extends State<SEMobileplos> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController serialTextController = TextEditingController();
  final TextEditingController ploTextController = TextEditingController();
  final TextEditingController objectivesTextController =
      TextEditingController();
  bool _isLoading = false;
  Future<void> _addData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String serialNumber = serialTextController.text;
      String plo = ploTextController.text;
      String description = objectivesTextController.text;

      try {
        // Check if the serial number already exists
        final existingDocs = await FirebaseFirestore.instance
            .collection('seplos')
            .where('Sr#', isEqualTo: serialNumber)
            .get();

        if (existingDocs.docs.isNotEmpty) {
          _showMessage('Serial Number already exists');
        } else {
          await FirebaseFirestore.instance.collection('seplos').add({
            'Sr#': serialNumber,
            'PLO': plo,
            'Description': description,
          });
          _showMessage('Data added successfully');
          _resetFields();
        }
      } catch (e) {
        _showMessage('Failed to add data');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resetFields() {
    serialTextController.clear();
    ploTextController.clear();
    objectivesTextController.clear();
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteData(String docId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('seplos').doc(docId).delete();
      _showMessage('Data deleted successfully');
    } catch (e) {
      _showMessage('Failed to delete data');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _viewData(String serial, String plo, String description) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Serial No: $serial'),
            Text('PLO: $plo'),
            Text('Description: $description'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Close'),
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
          title: const Text("PLOs", style: TextStyle(color: Colors.white)),
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
                height: 140,
                color: Colors.lightBlueAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Serial No',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 200,
                                child: SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    cursorColor: Colors.blue,
                                    controller: serialTextController,
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                      hintText: "Sr#",
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Serial Number';
                                      }
                                      return null;
                                    },
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
                                  'Plo`s',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    cursorColor: Colors.blue,
                                    maxLines: 2,
                                    controller: ploTextController,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the objectives';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
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
                                  width: 250,
                                  child: TextFormField(
                                    cursorColor: Colors.blue,
                                    maxLines: 2,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the description';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              left: 20,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : _addData,
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
                          if (_isLoading)
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: CircularProgressIndicator(),
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
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('seplos').snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: 1000,
                        height: 518,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: DataTable(
                          dataRowMinHeight: 2,
                          dataRowMaxHeight: 75,
                          columns: const [
                            DataColumn(
                                label: Text(
                              "Serial #",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                            DataColumn(
                                label: Text(
                              "PLO",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                            DataColumn(
                                label: Text(
                              "Description",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                            DataColumn(
                                label: Text(
                              "Actions",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                          ],
                          rows: snapshot.data!.docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return DataRow(
                              cells: [
                                DataCell(SizedBox(
                                    width: 70, child: Text(data['Sr#'] ?? ''))),
                                DataCell(SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Text(data['PLO'] ?? ''))),
                                DataCell(Text(data['Description'] ?? '')),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          _viewData(
                                            data['Sr#'],
                                            data['PLO'],
                                            data['Description'],
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteData(doc.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
