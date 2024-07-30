import 'package:coopah_task/module/auth/data/datasources/network/url_config.dart';
import 'package:dio/dio.dart';

class DioClient {
  final String? baseUrl;
  Dio? _dio;

  DioClient({this.baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? UrlConfig.coreBaseUrl,
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
    );
  }

  Dio? get dio => _dio;
}
