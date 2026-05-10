import 'package:supabase_flutter/supabase_flutter.dart';

class AIService {
  static Future<String> getAIExplanation(String result, String type) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
        'medical-ai',
        body: {
          'result': result,
          'type': type,
        },
      );

      if (response.status == 200) {
        final data = response.data;
        return data['choices'][0]['message']['content'];
      } else {
        return "Insight generation is currently being processed. Please consult a specialist.";
      }
    } catch (e) {
      print("AI Error: $e");
      return "Connected to AI engine... Please ensure your Supabase Edge Function 'medical-ai' is deployed.";
    }
  }

  static Future<String> getChatResponse(String query, String result, String type) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
        'medical-ai-chat',
        body: {
          'query': query,
          'result': result,
          'type': type,
        },
      );

      if (response.status == 200) {
        return response.data['choices'][0]['message']['content'];
      }
      return "I'm having trouble connecting to my medical database. Please try again in a moment.";
    } catch (e) {
      return "I'm currently in offline mode. Please consult a doctor for specific medical advice.";
    }
  }
}

