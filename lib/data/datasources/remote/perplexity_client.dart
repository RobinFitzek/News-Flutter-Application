// ignore_for_file: unused_field
import 'package:dio/dio.dart';
import '../../../config/constants.dart';

class PerplexityClient {
  PerplexityClient()
      : _dio = Dio(BaseOptions(
          baseUrl: AppConstants.perplexityBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ));

  final Dio _dio;
  String? _apiKey;

  Future<void> setApiKey(String key) async {
    _apiKey = key;
  }

  Future<String> searchNews(String query) async {
    throw UnimplementedError('searchNews not yet implemented');
  }
}
