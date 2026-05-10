import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ml_service.dart';
import 'chat_assistant.dart';
import 'ai_service.dart';

class DetectionScreen extends StatefulWidget {
  final String modelType;
  final String title;

  const DetectionScreen({super.key, required this.modelType, required this.title});

  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  final MLService _mlService = MLService();
  
  XFile? _image;
  Uint8List? _imageBytes;
  String _result = '';
  String _aiInsight = '';
  bool _isAnalyzing = false;
  bool _isGeneratingInsight = false;

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
          _aiInsight = '';
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
        _isGeneratingInsight = true;
      });

      // Fetch Real-time AI Insight
      final insight = await AIService.getAIExplanation(res, widget.title);
      setState(() {
        _aiInsight = insight;
        _isGeneratingInsight = false;
      });

      // Upload to Supabase Storage and Save to History
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null && _image != null) {
        try {
          final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
          final path = '${user.id}/$fileName';
          
          // 1. Upload the image file
          await Supabase.instance.client.storage
              .from('analysis-images')
              .uploadBinary(
                path, 
                _imageBytes!,
                fileOptions: const FileOptions(contentType: 'image/png'),
              );
          
          // 2. Get the public URL
          final imageUrl = Supabase.instance.client.storage
              .from('analysis-images')
              .getPublicUrl(path);

          // Parse label and confidence from the result string (e.g. "Glioma\nConfidence: 85.0%")
          final lines = res.split('\n');
          final label = lines[0];
          double confidence = 0.95; // Default fallback
          if (lines.length > 1) {
            final confMatch = RegExp(r'(\d+\.?\d*)').firstMatch(lines[1]);
            if (confMatch != null) {
              confidence = double.parse(confMatch.group(1)!) / 100;
            }
          }
              
          // 3. Save the record with unified column names
          await Supabase.instance.client.from('analysis_history').insert({
            'user_id': user.id,
            'model_type': widget.modelType,
            'result_label': label,
            'confidence': confidence,
            'image_url': imageUrl,
          });
        } catch (e) {
          debugPrint('Error saving history or image: $e');
          // We don't update _result here because the analysis was successful
          // even if the history save failed.
        }
      }
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
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                        backgroundColor: const Color(0xFFFF3B30),
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
                            Text(
                              _result,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                            const SizedBox(height: 24),
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 24),
                            const Text(
                              '👨‍⚕️ Medical Insight',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _isGeneratingInsight 
                                ? "Generating AI Insight..." 
                                : _aiInsight.isNotEmpty ? _aiInsight : _getHumanExplanation(_result),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.8), height: 1.5, fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ChatAssistant(
                                    scanResult: _result,
                                    scanType: widget.title,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline),
                              label: const Text('Chat with AI Doctor'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent.withOpacity(0.1),
                                foregroundColor: Colors.cyanAccent,
                                side: const BorderSide(color: Colors.cyanAccent),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 64),
                _buildAnalysisHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getHumanExplanation(String result) {
    final res = result.toLowerCase();
    
    // Brain Explanations
    if (res.contains('glioma')) {
      return "A glioma is a tumor that starts in the brain's support cells. These are often found deeper within the brain tissue. It's important to have a specialist look at the exact depth and location.";
    } else if (res.contains('meningioma')) {
      return "A meningioma is a growth that forms in the protective layers covering your brain. Most are slow-growing and not cancerous. It's usually found near the surface of the skull.";
    } else if (res.contains('pituitary')) {
      return "The pituitary is a tiny gland at the base of your brain that controls hormones. A growth here can affect how your body manages energy and growth.";
    } else if (res.contains('no tumor')) {
      return "Our AI scanned every pixel of this MRI and found no signs of abnormal growths. Your brain tissue patterns appear healthy and clear!";
    }
    
    // Skin Explanations (HAM10000 Dataset Categories)
    if (res.contains('actinic') || res.contains('akiec')) {
      return "Actinic Keratoses are rough, scaly patches on the skin caused by years of sun exposure. They are considered 'pre-cancerous' and should be treated to prevent them from turning into skin cancer.";
    } else if (res.contains('basal cell') || res.contains('bcc')) {
      return "Basal Cell Carcinoma is the most common form of skin cancer. It's slow-growing and rarely spreads, but should be removed to prevent damage to the surrounding skin.";
    } else if (res.contains('benign keratosis') || res.contains('bkl')) {
      return "These are common, non-cancerous skin growths. They can look concerning because they are dark or crusty, but they are completely harmless and part of natural skin aging.";
    } else if (res.contains('dermatofibroma') || res.contains('df')) {
      return "A dermatofibroma is a very common, harmless (benign) fibrous growth that often feels like a hard small bump under the skin. No treatment is usually necessary.";
    } else if (res.contains('melanoma') || res.contains('mel')) {
      return "Melanoma is a serious skin condition that often comes from pigment cells. Our AI noticed irregular borders and color patterns that need a dermatologist's immediate attention.";
    } else if (res.contains('melanocytic nevi') || res.contains('nv')) {
      return "This is a scientific name for a common mole. Our AI confirms this is a benign collection of pigment cells. Most people have many of these and they are perfectly normal.";
    } else if (res.contains('vascular') || res.contains('vasc')) {
      return "Vascular lesions are common skin growths made of blood vessels (like cherry angiomas). They are benign and harmless, though they can sometimes be removed for cosmetic reasons.";
    }

    return "Our AI is analyzing the unique patterns in your scan. Please consult with a medical professional for a comprehensive clinical diagnosis.";
  }

  Widget _buildAnalysisHistory() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return const SizedBox.shrink();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Supabase.instance.client
          .from('analysis_history')
          .select()
          .eq('model_type', widget.modelType)
          .order('created_at', ascending: false)
          .limit(5),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final history = snapshot.data!;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Past ${widget.title} History',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ...history.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                
                return Column(
                  children: [
                    _buildHistoryItem(
                      date: _formatDate(item['created_at']),
                      result: '${item['result_label']} (${(item['confidence'] * 100).toStringAsFixed(1)}%)',
                    ),
                    if (idx < history.length - 1)
                      const Divider(color: Colors.white24, height: 32),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryItem({required String date, required String result}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.modelType == 'brain' ? Colors.purpleAccent.withOpacity(0.2) : const Color(0xFFFF3B30).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            widget.modelType == 'brain' ? Icons.psychology : Icons.biotech,
            color: widget.modelType == 'brain' ? Colors.purpleAccent : const Color(0xFFFF3B30),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
              Text(
                result,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr).toLocal();
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
