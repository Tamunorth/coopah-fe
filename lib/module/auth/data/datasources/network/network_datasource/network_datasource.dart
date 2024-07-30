import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../dio_client/dio_client.dart';
import '../errors/api_error.dart';
import 'i_network_datasource.dart';

class NetworkDataSource implements INetworkDataSource {
  final DioClient _dioClient;

  NetworkDataSource(this._dioClient);

  @override
  Future<Response?> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dioClient.dio!.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (error, trace) {
      if (error is DioException) {
        throw ApiError.fromDio(error);
      }

      //show stacktrace
      if (kDebugMode) {
        print(trace);
      }

      throw ApiError.unknown(error);
    }
  }

  @override
  Future<Response?> post(String endpoint,
      {required Map<String, dynamic> data}) async {
    return null;
  }

  @override
  Future<Response?> put(String endpoint,
      {required Map<String, dynamic> data}) async {
    return null;
  }

  @override
  Future<Response?> delete(String endpoint) async {
    return null;
  }
}
