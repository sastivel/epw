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
        ? new Answer.fromJson(json['student_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.studentResponse != null) {
      data['student_response'] = this.studentResponse!.toJson();
    }
    return data;
  }
}