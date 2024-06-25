class Question {
  int? id;
  String? uuid;
  String? type;
  String? question;
  List<String>? options;
  String? answer;
  String? questionTamil;
  List<String>? optionsTamil;
  String? answerTamil;
  int? status;
  String? createdAt;
  String? updatedAt;

  Question(
      {this.id,
      this.uuid,
      this.type,
      this.question,
      this.options,
      this.answer,
      this.questionTamil,
      this.optionsTamil,
      this.answerTamil,
      this.status,
      this.createdAt,
      this.updatedAt});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    type = json['type'];
    question = json['question'];
    options = json['options'].cast<String>();
    answer = json['answer'];
    questionTamil = json['question_tamil'];
    optionsTamil = json['options_tamil'].cast<String>();
    answerTamil = json['answer_tamil'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['type'] = this.type;
    data['question'] = this.question;
    data['options'] = this.options;
    data['answer'] = this.answer;
    data['question_tamil'] = this.questionTamil;
    data['options_tamil'] = this.optionsTamil;
    data['answer_tamil'] = this.answerTamil;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}