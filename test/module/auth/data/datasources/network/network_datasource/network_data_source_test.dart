import 'package:coopah_task/module/auth/data/datasources/network/dio_client/dio_client.dart';
import 'package:coopah_task/module/auth/data/datasources/network/errors/api_error.dart';
import 'package:coopah_task/module/auth/data/datasources/network/network_datasource/network_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late NetworkDataSource dataSource;
  late MockDioClient mockDioClient;
  late MockDio mockDio;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();

    // Stub the dio getter to return our mock Dio
    when(() => mockDioClient.dio).thenReturn(mockDio);
    dataSource = NetworkDataSource(mockDioClient);
  });

  group('NetworkDataSource', () {
    const endpoint = '/test-endpoint';

    test('get method returns Response on success', () async {
      final response = Response<Map<String, dynamic>>(
        requestOptions: RequestOptions(path: endpoint),
        statusCode: 200,
        data: {'key': 'value'},
      );

      when(() => mockDio.get(endpoint,
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => response);

      final result = await dataSource.get(endpoint);

      expect(result, isNotNull);
      expect(result?.statusCode, equals(200));
      expect(result?.data, equals({'key': 'value'}));
      verify(() => mockDio.get(endpoint,
          queryParameters: any(named: 'queryParameters'))).called(1);
    });

    test('get method throws ApiError on DioException', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: endpoint),
        response: Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: endpoint),
          statusCode: 400,
          data: {'error': 'Bad Request'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockDio.get(endpoint,
              queryParameters: any(named: 'queryParameters')))
          .thenThrow(dioException);

      expect(() => dataSource.get(endpoint), throwsA(isA<ApiError>()));
      verify(() => mockDio.get(endpoint,
          queryParameters: any(named: 'queryParameters'))).called(1);
    });

    test('get method throws unknown ApiError on other exceptions', () async {
      final exception = Exception('Unexpected error');

      when(() => mockDio.get(endpoint,
          queryParameters: any(named: 'queryParameters'))).thenThrow(exception);

      expect(() => dataSource.get(endpoint), throwsA(isA<ApiError>()));
      verify(() => mockDio.get(endpoint,
          queryParameters: any(named: 'queryParameters'))).called(1);
    });
  });
}
