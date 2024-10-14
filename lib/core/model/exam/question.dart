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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['uuid'] = uuid;
    data['type'] = type;
    data['question'] = question;
    data['options'] = options;
    data['answer'] = answer;
    data['question_tamil'] = questionTamil;
    data['options_tamil'] = optionsTamil;
    data['answer_tamil'] = answerTamil;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}