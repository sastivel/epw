import 'exam.dart';

class GetExamIdResponse {
  int? success;
  String? msg;
  Exam? exam;

  GetExamIdResponse({this.success, this.msg, this.exam});

  GetExamIdResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    return data;
  }
}