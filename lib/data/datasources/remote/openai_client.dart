import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'ai_client_interface.dart';

class OpenAiClient implements AiClientInterface {
  OpenAiClient({
    required String apiKey,
    String model = 'gpt-4o',
    String baseUrl = AppConstants.openaiBaseUrl,
  })  : _model = model,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ));

  final String _model;
  final Dio _dio;

  @override
  String get providerType => 'openai';

  @override
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/models');
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  @override
  Future<String> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': _model,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        },
      );
      return response.data['choices'][0]['message']['content'] as String;
    } on DioException catch (e) {
      throw Exception(
        'OpenAI error: ${e.message ?? e.response?.statusCode}',
      );
    }
  }
}
