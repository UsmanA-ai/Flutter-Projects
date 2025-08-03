import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components.dart';
import 'package:url_launcher/url_launcher.dart';

class Studentportfoliofolder extends StatelessWidget {
  const Studentportfoliofolder({super.key});

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
                      child: StudentDrawer(),
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
                            Positioned(
                              top: 0,
                              child: StudentHeader(name: "Portfolio Folder"),
                            ),
                            Positioned(
                              top: 130,
                              left: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  width: 1000,
                                  height: 460,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  child:
                                      FutureBuilder<List<Map<String, dynamic>>>(
                                    future: fetchPortfolioData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                            child: Text("Error fetching data"));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text(
                                                "No portfolio data found"));
                                      }

                                      List<Map<String, dynamic>> data =
                                          snapshot.data!;
                                      return ListView.builder(
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          var portfolio = data[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      Colors.lightBlue.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5) // Light blue background
                                                  ),
                                              child: ListTile(
                                                title: Text(
                                                    portfolio['projectName'] ??
                                                        'No Project Name'),
                                                subtitle: Text(
                                                    portfolio['projecttype'] ??
                                                        'No Project Type'),
                                                leading: const Icon(
                                                    Icons.assignment),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                      Icons.download),
                                                  onPressed: () => _launchURL(
                                                      context,
                                                      portfolio['fileUrl']),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
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

  Future<String> fetchStudentId() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(user!.uid)
        .get();
    return (snapshot.data() as Map<String, dynamic>)['Id'];
  }

  Future<List<Map<String, dynamic>>> fetchPortfolioData() async {
    String studentId = await fetchStudentId();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('portfolio')
        .where('studentId', isEqualTo: studentId)
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Could not launch URL."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
