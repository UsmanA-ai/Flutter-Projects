import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ComplainsMobileFolder extends StatefulWidget {
  final String collectionName;

  const ComplainsMobileFolder({super.key, required this.collectionName});

  @override
  State<ComplainsMobileFolder> createState() => _ComplainsFolderState();
}

class _ComplainsFolderState extends State<ComplainsMobileFolder> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _complainsData = [];

  @override
  void initState() {
    super.initState();
    _fetchComplainsData();
  }

  Future<void> _fetchComplainsData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(widget.collectionName).get();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("View Complains",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Id",style: TextStyle(color: Colors.blue,fontSize: 20),)),
                    DataColumn(label: Text("Name",style: TextStyle(color: Colors.blue,fontSize: 20),)),
                    DataColumn(label: Text("Email",style: TextStyle(color: Colors.blue,fontSize: 20),)),
                    DataColumn(label: Text("Message",style: TextStyle(color: Colors.blue,fontSize: 20),)),
                    DataColumn(label: Text("Actions",style: TextStyle(color: Colors.blue,fontSize: 20),)),
                  ],
                  rows: _complainsData.map((complain) {
                    return DataRow(
                      cells: [
                        DataCell(Text(complain["Id"].toString())),
                        DataCell(Text(complain["Name"])),
                        DataCell(Text(complain["Email"])),
                        DataCell(
                          SizedBox(
                            width: 200, // Adjust the width as needed
                            child: Tooltip(
                              message: complain["Message"],
                              child: Text(
                                complain["Message"],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.visibility),
                            color: complain["viewed"] == true ? Colors.green : Colors.red,
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
        ),
      )
    );
  }
}
