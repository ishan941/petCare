import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/response/response.dart';

class Api{
  Dio dio = Dio();
 post(String url, var data)async{
 try{
  Response response = await dio.post(url, data: data);
if(response.statusCode == 200|| response.statusCode == 201){
  return Apiresponse(statusUtil: StatusUtil.success);

}else {
  return Apiresponse(statusUtil: StatusUtil.error, errorMessage: badRequestStr);
}
 } on DioError catch (e){
  if(e.error is SocketException){
    return Apiresponse(statusUtil: StatusUtil.error, errorMessage: noInternetStr);
  }
  else if(e.response!.statusCode==400){
    return Apiresponse(statusUtil: StatusUtil.error, errorMessage: e.response!.statusMessage);
  }else{
    return Apiresponse(statusUtil: StatusUtil.error, errorMessage: e.toString());
  }
 }
 }
}
