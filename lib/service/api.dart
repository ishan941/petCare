import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/response/response.dart';

class Api {
  Dio dio = Dio();

  Api() {
    dio.options.headers['content-type'] = "application/json";
  }

  Future<ApiResponse> post(String url, var data, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(statusUtil: StatusUtil.success, data: response.data);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      } else if (e.error is SocketException) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: noInternetStr);
      } 

      else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
  }

  Future<ApiResponse> put(String url, var data, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.put(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(statusUtil: StatusUtil.success, data: response.data);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      } else if (e.error is SocketException) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: noInternetStr);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
  }

  Future<ApiResponse> get(String url, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        // Successful GET request
        return ApiResponse(statusUtil: StatusUtil.success, data: response.data);
      } else {
        // Handle other status codes if needed
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      } else if (e.response?.statusCode == 403) {
        return ApiResponse(
            statusUtil: StatusUtil.error,
            errorMessage: e.toString(),
            status_code: e.response?.statusCode);
      } else if (e.error is SocketException) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: noInternetStr);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
  }

  Future<ApiResponse> delete(String url, {String? token}) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = "Bearer $token";
      }
      Response response = await dio.delete(url);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse(statusUtil: StatusUtil.success);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: badRequestStr);
      } else if (e.error is SocketException) {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: noInternetStr);
      } else {
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    }
  }
}
