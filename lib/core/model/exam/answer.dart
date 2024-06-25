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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['exam_id'] = this.examId;
    data['question_id'] = this.questionId;
    data['correct_answer'] = this.correctAnswer;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}