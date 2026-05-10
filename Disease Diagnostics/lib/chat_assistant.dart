import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatAssistant extends StatefulWidget {
  final String scanResult;
  final String scanType;

  const ChatAssistant({super.key, required this.scanResult, required this.scanType});

  @override
  _ChatAssistantState createState() => _ChatAssistantState();
}

class _ChatAssistantState extends State<ChatAssistant> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages.add({
      'role': 'assistant',
      'content': "Hello! I am your AI Medical Assistant. I see your ${widget.scanType} scan showed: **${widget.scanResult}**. \n\nHow can I help you understand these results today?",
    });
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    setState(() {
      _messages.add({'role': 'user', 'content': userMessage});
      _controller.clear();
      _isTyping = true;
    });

    // Simulate AI Response (Real-time feel)
    await Future.delayed(const Duration(seconds: 1));
    
    String response = _generateDynamicResponse(userMessage);

    setState(() {
      _isTyping = false;
      _messages.add({'role': 'assistant', 'content': response});
    });
  }

  String _generateDynamicResponse(String query) {
    final q = query.toLowerCase();
    
    if (q.contains('next steps') || q.contains('what should i do')) {
      return "The most important next step is to consult with a specialist. For ${widget.scanType} scans, we recommend sharing this result with a neurologist or dermatologist immediately for a clinical follow-up.";
    } else if (q.contains('dangerous') || q.contains('serious')) {
      if (widget.scanResult.toLowerCase().contains('no tumor') || widget.scanResult.toLowerCase().contains('normal')) {
        return "Based on the scan, it does not appear to be dangerous. However, if you are experiencing symptoms, always trust your physical feelings over an AI scan.";
      }
      return "Any abnormal finding in a ${widget.scanType} scan should be taken seriously. While our AI is highly accurate, it is a screening tool and not a final medical diagnosis.";
    } else if (q.contains('treatment')) {
      return "Treatment options vary widely. For ${widget.scanResult}, doctors might suggest monitoring, specialized medication, or in some cases, a biopsy or surgical consult.";
    } else if (q.contains('hello') || q.contains('hi')) {
      return "Hello! I'm here to help you navigate your diagnostic results. What specific questions do you have about your scan?";
    }

    return "That's a great question. In the context of your result (**${widget.scanResult}**), a medical professional would look at your full history. Would you like me to explain more about what this specific condition is?";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.cyanAccent,
                      child: Icon(Icons.smart_toy, color: Colors.black),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AI Medical Assistant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("Real-time Diagnostic Support", style: TextStyle(color: Colors.cyanAccent, fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg['role'] == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.cyanAccent.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUser ? Colors.cyanAccent.withOpacity(0.3) : Colors.white.withOpacity(0.1)),
                        ),
                        child: Text(
                          msg['content']!,
                          style: TextStyle(color: isUser ? Colors.cyanAccent : Colors.white, height: 1.4),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              if (_isTyping)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      Text("AI is thinking...", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                    ],
                  ),
                ),

              // Input
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Ask anything about your scan...",
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filled(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send),
                      style: IconButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
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
