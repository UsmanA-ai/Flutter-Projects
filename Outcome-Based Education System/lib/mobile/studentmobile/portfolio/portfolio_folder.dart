import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class StudentMobileportfoliofolder extends StatelessWidget {
  const StudentMobileportfoliofolder({super.key});
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
          title: const Text("Portfolio Folder", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // width: 1000,
                height: 730,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchPortfolioData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error fetching data"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No portfolio data found"));
                    }

                    List<Map<String, dynamic>> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var portfolio = data[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration:BoxDecoration(
                                color: Colors.lightBlue.shade100,
                                borderRadius: BorderRadius.circular(5)// Light blue background
                            ),
                            child: ListTile(
                              title: Text(portfolio['projectName'] ?? 'No Project Name'),
                              subtitle: Text(portfolio['projecttype'] ?? 'No Project Type'),
                              leading: const Icon(Icons.assignment),
                              trailing: IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () => _launchURL(context, portfolio['fileUrl']),
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
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  Future<void> _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

