import 'package:EPW_mobile/core/model/exam/exam.dart';

class Scorecard {
  Exam? exam;
  int? correctAnswerCount;

  Scorecard({this.exam, this.correctAnswerCount});

  Scorecard.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
    correctAnswerCount = json['correct_answer_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    data['correct_answer_count'] = correctAnswerCount;
    return data;
  }
}