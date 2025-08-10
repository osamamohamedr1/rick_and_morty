import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: 'Connection timed out.\nCheck your internet.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Request took too long to send.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Server took too long to respond.');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Invalid security certificate.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'No internet connection.');
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure(errorMessage: 'No internet connection.');
        }
        return ServerFailure(errorMessage: 'Unexpected error.\nTry again.');
      // ignore: unreachable_switch_default
      default:
        return ServerFailure(errorMessage: 'Something went wrong.\nTry again.');
    }
  }
  static String getErrorMessage(dynamic response) {
    if (response is Map) {
      return response['message'];
    } else {
      return 'Something went wrong.';
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: getErrorMessage(response));
    } else if (statusCode == 404) {
      return ServerFailure(errorMessage: 'Request not found.');
    } else if (statusCode == 500) {
      return ServerFailure(errorMessage: 'Server error. Try again later.');
    } else {
      return ServerFailure(errorMessage: 'Something went wrong.');
    }
  }
}

class HiveFailure extends Failure {
  HiveFailure({required super.errorMessage});

  factory HiveFailure.fromHiveError(Object e) {
    if (e is HiveError) {
      return HiveFailure(errorMessage: 'Hive internal error: ${e.message}');
    } else if (e is TypeError) {
      return HiveFailure(errorMessage: 'Data type mismatch in Hive.');
    } else if (e is FileSystemException) {
      return HiveFailure(errorMessage: 'Error accessing Hive storage.');
    } else {
      return HiveFailure(errorMessage: 'Unexpected Hive error.');
    }
  }
}
