import 'dart:convert';
import 'package:dio/dio.dart';

/// Service to fetch AI-powered cure suggestions for plant diseases using Gemini API.
class PlantDiseaseService {
  final Dio _dio;
  PlantDiseaseService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches a structured cure suggestion for a given [diseaseName] from Gemini.
  /// Returns a Map<String, dynamic> with keys: title, steps, tips. Falls back to null on error.
  Future<Map<String, dynamic>?> getCureSuggestionsFromDiseaseName(
    String diseaseName,
  ) async {
    // TODO: Move API key to secure storage/environment for production use.
    const apiKey = "AIzaSyCRCV0oxcZKSsCorysvaEX3eRfyB9Y0cAI";
    const apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey";

    final prompt =
        '''
You are a plant disease expert. Given the disease: $diseaseName,
provide a cure suggestion in this JSON format:
{
  "title": "...",
  "steps": ["...", "..."],
  "tips": ["...", "..."]
}
Only return valid JSON, no extra text.
''';

    final Map<String, dynamic> payload = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt},
          ],
        },
      ],
    };

    try {
      final response = await _dio.post(
        apiUrl,
        data: payload,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['candidates'] != null &&
            jsonResponse['candidates'].isNotEmpty &&
            jsonResponse['candidates'][0]['content'] != null &&
            jsonResponse['candidates'][0]['content']['parts'] != null &&
            jsonResponse['candidates'][0]['content']['parts'].isNotEmpty) {
          String text =
              jsonResponse['candidates'][0]['content']['parts'][0]['text'];
          // Clean up: Remove code block markers and stars
          text = text.trim();
          if (text.startsWith('```json')) {
            text = text.replaceAll(RegExp(r'^```json|```'), '').trim();
          } else if (text.startsWith('```')) {
            text = text.replaceAll(RegExp(r'^```|```'), '').trim();
          }
          // Remove Markdown stars and extra formatting
          text = text.replaceAll(RegExp(r'^\*+|\*+$'), '').trim();
          // Try to parse JSON
          try {
            final map = json.decode(text);
            if (map is Map<String, dynamic>) {
              return map;
            }
          } catch (_) {
            // Fallback: try to extract JSON substring
            final start = text.indexOf('{');
            final end = text.lastIndexOf('}');
            if (start != -1 && end != -1 && end > start) {
              final jsonString = text.substring(start, end + 1);
              try {
                final map = json.decode(jsonString);
                if (map is Map<String, dynamic>) {
                  return map;
                }
              } catch (_) {}
            }
          }
          return null; // Could not parse JSON
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
