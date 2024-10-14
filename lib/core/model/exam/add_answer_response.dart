// ignore_for_file: prefer_collection_literals

import 'answer.dart';

class AddAnswerResponse {
  int? success;
  String? msg;
  Answer? studentResponse;

  AddAnswerResponse({this.success, this.msg, this.studentResponse});

  AddAnswerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    studentResponse = json['student_response'] != null
        ? Answer.fromJson(json['student_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    if (studentResponse != null) {
      data['student_response'] = studentResponse!.toJson();
    }
    return data;
  }
}