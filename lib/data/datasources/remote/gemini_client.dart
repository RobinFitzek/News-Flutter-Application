import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'ai_client_interface.dart';

class GeminiClient implements AiClientInterface {
  GeminiClient({
    required this.apiKey,
    String model = 'gemini-2.0-flash',
  }) : model = model,
       _dio = Dio(BaseOptions(
         baseUrl: AppConstants.geminiBaseUrl,
         connectTimeout: const Duration(seconds: 15),
         receiveTimeout: const Duration(seconds: 60),
       ));

  final String apiKey;
  final String model;
  final Dio _dio;

  @override
  String get providerType => 'gemini';

  @override
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/models', queryParameters: {
        'key': apiKey,
      });
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  @override
  Future<String> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        '/models/$model:generateContent',
        queryParameters: {'key': apiKey},
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'responseMimeType': 'application/json',
          },
        },
      );
      return response.data['candidates'][0]['content']['parts'][0]['text']
          as String;
    } on DioException catch (e) {
      throw Exception(
        'Gemini error: ${e.message ?? e.response?.statusCode}',
      );
    }
  }
}
