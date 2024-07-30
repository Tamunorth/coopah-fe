import 'package:dio/dio.dart';

abstract class INetworkDataSource {
  Future<Response?> get(String endpoint);
  Future<Response?> post(String endpoint, {required Map<String, dynamic> data});
  Future<Response?> put(String endpoint, {required Map<String, dynamic> data});
  Future<Response?> delete(String endpoint);
}
