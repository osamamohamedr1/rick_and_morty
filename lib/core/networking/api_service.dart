import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/utils/const.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options = BaseOptions(baseUrl: kBaseUrl);
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await dio.get(endPoint, queryParameters: queryParams);
    return response.data;
  }
}
