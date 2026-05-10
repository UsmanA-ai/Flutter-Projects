import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_keys.dart';

class AIService {
  static Future<String> getAIExplanation(String result, String type) async {
    if (ApiKeys.groqApiKey == 'YOUR_GROQ_API_KEY_HERE') {
      return "Please set your Groq API key in api_keys.dart to enable real-time AI insights.";
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${ApiKeys.groqApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'llama-3.1-8b-instant',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a compassionate medical AI assistant. Explain the following diagnostic result in simple, human terms. Keep it under 3 sentences. Be empathetic but professional. Mention next steps (consulting a doctor). Type: $type',
            },
            {'role': 'user', 'content': 'Result: $result'},
          ],
          'temperature': 0.7,
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "Our AI is briefly unavailable. Based on standard clinical data, this result usually suggests ${result.toLowerCase()}. Please consult a specialist.";
      }
    } catch (e) {
      return "Error connecting to AI service. Please ensure you have a stable internet connection.";
    }
  }
}
