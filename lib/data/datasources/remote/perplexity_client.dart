import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'ai_client_interface.dart';

class PerplexityClient implements AiClientInterface {
  PerplexityClient({
    required String apiKey,
    String model = 'sonar-pro',
  })  : model = model,
        _dio = Dio(BaseOptions(
          baseUrl: AppConstants.perplexityBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ));

  final String model;
  final Dio _dio;

  @override
  String get providerType => 'perplexity';

  @override
  Future<bool> testConnection() async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': model,
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
        '/chat/completions',
        data: {
          'model': model,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        },
      );
      return response.data['choices'][0]['message']['content'] as String;
    } on DioException catch (e) {
      throw Exception(
        'Perplexity error: ${e.message ?? e.response?.statusCode}',
      );
    }
  }
}
