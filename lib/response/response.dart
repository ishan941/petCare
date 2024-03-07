import 'package:project_petcare/core/statusutil.dart';

class FireResponse {
  String? errorMessage, successMessage;
  dynamic data;
  StatusUtil statusUtil;
  FireResponse(
      {required this.statusUtil,
      this.data,
      this.errorMessage,
      this.successMessage});
}
class ApiResponse{
  String? errorMessage;
  dynamic data;
  StatusUtil statusUtil;
  final int? status_code;
  
  ApiResponse({
   required this.statusUtil,
    this.data,
    this.errorMessage,
    this.status_code,
  });
}

