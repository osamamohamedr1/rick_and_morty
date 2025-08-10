import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options = BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/');
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await dio.get(endPoint, queryParameters: queryParams);
    return response.data;
  }
}
