import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'ml_service.dart';

class DetectionScreen extends StatefulWidget {
  final String modelType;
  final String title;

  const DetectionScreen({Key? key, required this.modelType, required this.title}) : super(key: key);

  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  final MLService _mlService = MLService();
  
  XFile? _image;
  Uint8List? _imageBytes;
  String _result = '';
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _mlService.loadModels();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = pickedFile;
          _imageBytes = bytes;
          _result = '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;

    setState(() {
      _isAnalyzing = true;
      _result = '';
    });

    try {
      String res;
      if (widget.modelType == 'brain') {
        res = await _mlService.predictBrainTumor(_image!);
      } else {
        res = await _mlService.predictSkinCancer(_image!);
      }

      setState(() {
        _result = res;
      });
    } catch (e) {
      setState(() {
        _result = 'Error during analysis: $e';
      });
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_imageBytes != null)
                  Container(
                    constraints: const BoxConstraints(maxHeight: 450, maxWidth: 600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 15)),
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.memory(_imageBytes!, fit: BoxFit.contain),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 600),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 2, style: BorderStyle.solid),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload_outlined, size: 80, color: Colors.white.withOpacity(0.6)),
                            const SizedBox(height: 24),
                            Text('Click to upload image', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text('Supported formats: JPG, PNG', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                
                const SizedBox(height: 48),
                
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Change Image'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        minimumSize: const Size(240, 64),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        side: BorderSide(color: Colors.white.withOpacity(0.2)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _image != null && !_isAnalyzing ? _analyzeImage : null,
                      icon: _isAnalyzing 
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.biotech),
                      label: Text(_isAnalyzing ? 'Analyzing...' : 'Run Diagnostics'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        minimumSize: const Size(240, 64),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        elevation: 10,
                        shadowColor: Colors.cyan.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
                
                if (_result.isNotEmpty) ...[
                  const SizedBox(height: 64),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 600),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Diagnostic Result',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.cyanAccent, letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _result,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
