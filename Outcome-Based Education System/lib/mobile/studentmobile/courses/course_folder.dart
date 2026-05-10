import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentMobileCourseFolder extends StatefulWidget {
  final String courseName;
  const StudentMobileCourseFolder({super.key, required this.courseName});

  @override
  _StudentMobileCourseFolderState createState() => _StudentMobileCourseFolderState();
}

class _StudentMobileCourseFolderState extends State<StudentMobileCourseFolder> {
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
      if (url != null && await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
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
          title: const Text("Course Folder", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightBlue.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        "Course Name: ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.courseName, // Display provided course name
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Display the fetched files in a ListView
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  height: 685,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23),
                      bottomRight: Radius.circular(23)
                    ),
                  ),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _isLoading,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      Visibility(
                        visible: !_isLoading,
                        child: ListView.builder(
                          itemCount: _files.length,
                          itemBuilder: (context, index) {
                            final file = _files[index];
                            return ListTile(
                              title: Text(file['fileName']),
                              subtitle: Text(file['uploadDate']),
                              trailing: _buildPopupMenuButton(file),
                            );
                          },
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
    );
  }
}


