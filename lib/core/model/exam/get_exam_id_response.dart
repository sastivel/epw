import 'exam.dart';

class GetExamIdResponse {
  int? success;
  String? msg;
  Exam? exam;

  GetExamIdResponse({this.success, this.msg, this.exam});

  GetExamIdResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    return data;
  }
}