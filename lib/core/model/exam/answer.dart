// ignore_for_file: prefer_collection_literals

class Answer {
  String? uuid;
  int? examId;
  int? questionId;
  int? correctAnswer;
  String? updatedAt;
  String? createdAt;
  int? id;

  Answer(
      {this.uuid,
      this.examId,
      this.questionId,
      this.correctAnswer,
      this.updatedAt,
      this.createdAt,
      this.id});

  Answer.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    examId = json['exam_id'];
    questionId = json['question_id'];
    correctAnswer = json['correct_answer'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = uuid;
    data['exam_id'] = examId;
    data['question_id'] = questionId;
    data['correct_answer'] = correctAnswer;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}