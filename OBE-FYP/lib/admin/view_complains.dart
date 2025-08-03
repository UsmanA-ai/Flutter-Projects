import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components.dart';

class ComplainsFolder extends StatefulWidget {
  final String collectionName;

  const ComplainsFolder({super.key, required this.collectionName});

  @override
  State<ComplainsFolder> createState() => _ComplainsFolderState();
}

class _ComplainsFolderState extends State<ComplainsFolder> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _complainsData = [];

  @override
  void initState() {
    super.initState();
    _fetchComplainsData();
  }

  Future<void> _fetchComplainsData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get();
      final complains = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["viewed"] = data["viewed"] ?? false; // Ensure "viewed" is not null
        return data;
      }).toList();

      setState(() {
        _complainsData = complains;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to load data: $e');
    }
  }

  void _showQuickView(Map<String, dynamic> complain) {
    setState(() {
      complain["viewed"] = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quick View'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${complain["Id"]}'),
                Text('Name: ${complain["Name"]}'),
                Text('Email: ${complain["Email"]}'),
                Text('Message: ${complain["Message"]}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
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
                      child: Row(
                        children: [
                          const Expanded(
                            child: AdminDrawer(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue.shade50,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  const Positioned(
                                    top: 0,
                                    child: FacultyHeader(
                                      name: "View Complains",
                                    ),
                                  ),
                                  Positioned(
                                    top: 180,
                                    left: 50,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        width: 1000,
                                        height: 450,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: DataTable(
                                          columns: const [
                                            DataColumn(
                                                label: Text(
                                              "Id",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Name",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Email",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Message",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Actions",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            )),
                                          ],
                                          rows: _complainsData.map((complain) {
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(
                                                    complain["Id"].toString())),
                                                DataCell(
                                                    Text(complain["Name"])),
                                                DataCell(
                                                    Text(complain["Email"])),
                                                DataCell(
                                                  SizedBox(
                                                    width:
                                                        200, // Adjust the width as needed
                                                    child: Tooltip(
                                                      message:
                                                          complain["Message"],
                                                      child: Text(
                                                        complain["Message"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.visibility),
                                                    color: complain["viewed"] ==
                                                            true
                                                        ? Colors.green
                                                        : Colors.red,
                                                    onPressed: () {
                                                      _showQuickView(complain);
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
