import 'package:canaluno/exceptions/api_exception.dart';
import 'package:canaluno/util/deserialize_jwt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  factory ApiClient() {
    return _instance;
  }

  // TODO: ajustar para usar url quando configurar o container
  final _baseUrl = 'http://api:8080/api';

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = globalToken;
          if (token != '') {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response != null) {
            ApiException apiException;
            switch (error.response!.statusCode) {
              case 400:
                apiException = ApiException(message: error.response?.data, statusCode: 400);
                break;
              case 403:
                apiException = ApiException(message: 'Acesso negado', statusCode: 403);
                break;
              case 404:
                apiException = ApiException(message: 'Recurso não encontrado', statusCode: 404);
                break;
              case 500:
                apiException = ApiException(message: 'Erro interno no servidor', statusCode: 500);
                break;
              default:
                apiException = ApiException(
                  message: error.response?.data['message'] ?? 'Erro desconhecido',
                  statusCode: error.response!.statusCode,
                );
            }
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                response: error.response,
                type: DioExceptionType.badResponse,
                error: apiException,
              ),
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get instance => _dio;
}
