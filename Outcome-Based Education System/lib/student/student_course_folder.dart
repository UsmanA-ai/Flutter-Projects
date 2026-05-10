import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/components.dart';

class StudentCourseFolder extends StatefulWidget {
  final String courseName;
  const StudentCourseFolder({super.key, required this.courseName});

  @override
  _StudentCourseFolderState createState() => _StudentCourseFolderState();
}

class _StudentCourseFolderState extends State<StudentCourseFolder> {
  bool _isLoading = true; // Indicates whether data is being fetched
  List<DocumentSnapshot> _files = [];

  @override
  void initState() {
    super.initState();
    _fetchFiles();
  }

  Future<void> _fetchFiles() async {
    setState(() {
      _isLoading = true; // Set loading state
    });
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('files')
          .where('CourseName', isEqualTo: widget.courseName)
          .get();

      setState(() {
        _files = querySnapshot.docs;
      });
    } catch (e) {
      print('Error fetching files: $e');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  Future<void> _downloadFile(DocumentSnapshot file) async {
    try {
      final url = file['filesurl'];
      if (url != null) {
        // Launch the URL in the default browser
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  Widget _buildPopupMenuButton(DocumentSnapshot file) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'download',
          child: Text('Download'),
        ),
      ],
      onSelected: (value) async {
        if (!mounted) return; // Check if the widget is still mounted
        if (value == 'download') {
          await _downloadFile(file); // Implement download file method
        }
      },
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
              //bottom: 0,
              child: Container(
                width: 1386,
                height: 70,
                color: Colors.lightBlueAccent.shade100,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              //bottom: 0,
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
                      child: StudentDrawer(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          color: Colors.lightBlue.shade50,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 0,
                              child: FacultyHeader(name: "Course Folder"),
                            ),
                            Positioned(
                              top: 130,
                              left: 50,
                              child: Container(
                                width: 1000,
                                height: 450,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Course Name:",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget
                                                .courseName, // Display provided course name
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Display the fetched files in a ListView
                                    Container(
                                      width: 950,
                                      height: 370,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent.shade100,
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                      child: Stack(
                                        children: [
                                          Visibility(
                                            visible: _isLoading,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          Visibility(
                                            visible: !_isLoading,
                                            child: ListView.builder(
                                              itemCount: _files.length,
                                              itemBuilder: (context, index) {
                                                final file = _files[index];
                                                return ListTile(
                                                  title: Text(file['fileName']),
                                                  subtitle:
                                                      Text(file['uploadDate']),
                                                  trailing:
                                                      _buildPopupMenuButton(
                                                          file),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
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
            ),
          ],
        ),
      ),
    );
  }
}
