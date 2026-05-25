// ignore_for_file: unused_field
import 'package:dio/dio.dart';
import '../../../config/constants.dart';

class GeminiClient {
  GeminiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: AppConstants.geminiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ));

  final Dio _dio;
  String? _apiKey;

  Future<void> setApiKey(String key) async {
    _apiKey = key;
  }

  Future<String> generateAnalysis(String prompt) async {
    throw UnimplementedError('generateAnalysis not yet implemented');
  }
}
