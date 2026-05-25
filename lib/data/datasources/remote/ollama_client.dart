import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'ai_client_interface.dart';

class OllamaClient implements AiClientInterface {
  OllamaClient({
    String baseUrl = AppConstants.ollamaBaseUrl,
    String model = 'llama3',
  })  : _model = model,
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 120),
        ));

  final String _model;
  final Dio _dio;

  @override
  String get providerType => 'ollama';

  @override
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/api/tags');
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  @override
  Future<String> generateText(String prompt) async {
    try {
      final response = await _dio.post(
        '/api/generate',
        data: {
          'model': _model,
          'prompt': prompt,
          'stream': false,
        },
      );
      return response.data['response'] as String;
    } on DioException catch (e) {
      throw Exception(
        'Ollama error: ${e.message ?? e.response?.statusCode}',
      );
    }
  }
}
