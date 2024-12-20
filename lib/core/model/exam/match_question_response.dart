import 'package:EPW_mobile/core/model/exam/question.dart';

class MatchQuestionResponse {
  int? success;
  String? msg;
  List<Question>? question;

  MatchQuestionResponse({this.success, this.msg, this.question});

  MatchQuestionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['question'] != null) {
      question = <Question>[];
      json['question'].forEach((v) {
        question!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    if (question != null) {
      data['question'] = question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}