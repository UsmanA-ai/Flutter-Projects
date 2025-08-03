import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/utils/cloudinary_uploader.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class UploadMobilefolder extends StatefulWidget {
  final String courseName;

  const UploadMobilefolder({super.key, required this.courseName});

  @override
  _UploadMobilefolderState createState() => _UploadMobilefolderState();
}

class _UploadMobilefolderState extends State<UploadMobilefolder> {
  Uint8List? _selectedFileBytes;
  String? _fileName;
  String? _uploadDate;
  String? _fileUrl;
  bool _isUploading = false;
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

  late FilePickerResult result;
  Future<void> _pickFile() async {
    try {
      FilePickerResult? resultTemp = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['doc', 'docx', 'pdf', 'xls', 'xlsx', 'ppt', 'pptx'],
      );

      if (resultTemp != null && resultTemp.files.single.bytes != null) {
        setState(() {
          result = resultTemp;
          _selectedFileBytes = resultTemp.files.single.bytes;
          _fileName = resultTemp.files.single.name;
          _uploadDate = DateTime.now().toString();
        });
      } else {}
    } catch (e) {}
  }

  Future<void> _uploadFile() async {
    if (_selectedFileBytes == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      if (kIsWeb) {
        // Web: Only use bytes
        _fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: _selectedFileBytes!,
            imageFile: null,
            fileName: _fileName, // Optional file name
            foldername: 'raw_uploads',
            isRaw: true);
        print("Uploaded Image URL: $_fileUrl");
      } else {
        // Mobile/Desktop: Use file path
        File file = File(result.files.single.path!);
        _fileUrl = await CloudinaryUploader.uploadImage(
            imageBytes: result.files.single.bytes!,
            imageFile: file,
            fileName: _fileName, // Optional file name
            foldername: 'raw_uploads');
        print("Uploaded Image URL: $_fileUrl");
      }
      await FirebaseFirestore.instance.collection('files').add({
        'CourseName': widget.courseName,
        'filesurl': _fileUrl,
        'fileName': _fileName,
        'uploadDate': _uploadDate,
      });

      // After uploading, refetch files
      await _fetchFiles();

      setState(() {
        _selectedFileBytes = null;
        _fileName = null;
        _uploadDate = null;
        _fileUrl = null;
      });

      // Show success message
      _showAlert("File uploaded successfully");
    } catch (e) {
      // Show error message
      _showAlert("Error uploading file: $e");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _deleteFile(DocumentSnapshot file) async {
    try {
      setState(() {
        _isLoading = true; // Set loading state
      });
      await FirebaseFirestore.instance
          .collection('files')
          .doc(file.id)
          .delete();

      // After deletion, refetch files
      await _fetchFiles();

      // Show success message
      _showAlert("File deleted successfully");
    } catch (e) {
      // Show error message
      _showAlert("Error deleting file: $e");
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
        if (await canLaunch(url)) {
          await launch(url);
          print('File redirected to browser successfully');
        } else {
          print('Could not launch $url');
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
          value: 'delete',
          child: Text('Delete'),
        ),
        const PopupMenuItem(
          value: 'download',
          child: Text('Download'),
        ),
      ],
      onSelected: (value) async {
        if (!mounted) return; // Check if the widget is still mounted
        if (value == 'delete') {
          await _deleteFile(file); // Implement delete file method
        } else if (value == 'download') {
          await _downloadFile(file); // Implement download file method
        }
      },
    );
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Course Upload Files",
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
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.courseName, // Display provided course name
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _pickFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "Add File",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (_fileName != null)
                      Column(
                        children: [
                          Text('Selected File: $_fileName'),
                          Text('Date: $_uploadDate'),
                        ],
                      ),
                    const SizedBox(width: 20),
                    if (_isUploading) const CircularProgressIndicator(),
                    if (!_isUploading) const SizedBox(width: 20),
                    Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _uploadFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "Upload File",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 950,
                height: 583,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade100,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23)),
                ),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _isLoading,
                      child: const Center(
                        child: CircularProgressIndicator(),
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
                            subtitle: Text(file['uploadDate']),
                            trailing: _buildPopupMenuButton(file),
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
    );
  }
}
