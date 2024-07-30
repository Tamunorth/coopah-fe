import 'package:dio/dio.dart';

class ApiError implements Exception {
  final String message;

  ApiError(this.message);

  /// Constructor to handle DioError
  factory ApiError.fromDio(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiError('Request to API was cancelled');
      case DioExceptionType.connectionTimeout:
        return ApiError('Connection timeout with API, Please try again');
      case DioExceptionType.sendTimeout:
        return ApiError('Send timeout in connection with API');
      case DioExceptionType.receiveTimeout:
        return ApiError('Receive timeout in connection with API');
      case DioExceptionType.badResponse:
        return ApiError(
            'Received invalid status code: ${dioError.response?.statusCode}');
      case DioExceptionType.unknown:
        return ApiError(dioError.message ?? '');
      default:
        return ApiError('Oops!, Something went wrong, Please try again');
    }
  }
  factory ApiError.unknown(dynamic dioError) {
    return ApiError('Oops!, Something went wrong, Please try again');
  }

  @override
  String toString() {
    return message;
  }
}
