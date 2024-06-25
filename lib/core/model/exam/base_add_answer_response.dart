import 'answer.dart';

class BaseAddAnswerResponse {
  int? success;
  String? msg;
  

  BaseAddAnswerResponse({this.success, this.msg});

  BaseAddAnswerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    return data;
  }
}