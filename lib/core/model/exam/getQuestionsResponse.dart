
import 'package:EPW_mobile/core/model/exam/question.dart';

class GetQuestionResponse {
  int? success;
  String? msg;
  Question? question;
  bool? isLastQuestion;

  GetQuestionResponse(
      {this.success, this.msg, this.question, this.isLastQuestion});

  GetQuestionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    isLastQuestion = json['is_last_question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    data['is_last_question'] = this.isLastQuestion;
    return data;
  }
}