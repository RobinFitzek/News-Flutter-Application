import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'ai_client_interface.dart';

class ClaudeClient implements AiClientInterface {
  ClaudeClient({
    required String apiKey,
    String model = 'claude-3-5-sonnet-20241022',
  })  : _model = model,
        _dio = Dio(BaseOptions(
          baseUrl: AppConstants.anthropicBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'x-api-key': apiKey,
            'anthropic-version': '2023-06-01',
            'Content-Type': 'application/json',
          },
        ));

  final String _model;
  final Dio _dio;

  @override
  String get providerType => 'claude';

  @override
  Future<bool> testConnection() async {
    try {
      final response = await _dio.post(
        '/messages',
        data: {
          'model': _model,
          'max_tokens': 10,
          'messages': [
            {'role': 'user', 'content': 'ping'}
          ],
        },
      );
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  @override
  Future<String> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        '/messages',
        data: {
          'model': _model,
          'max_tokens': 1024,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        },
      );
      return response.data['content'][0]['text'] as String;
    } on DioException catch (e) {
      throw Exception(
        'Claude error: ${e.message ?? e.response?.statusCode}',
      );
    }
  }
}
