import 'package:EPW_mobile/core/model/exam/exam.dart';

class Scorecard {
  Exam? exam;
  int? correctAnswerCount;

  Scorecard({this.exam, this.correctAnswerCount});

  Scorecard.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
    correctAnswerCount = json['correct_answer_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    data['correct_answer_count'] = this.correctAnswerCount;
    return data;
  }
}