class GetScroreCardResponse {
  int? success;
  String? msg;
  Scorecard? scorecard;

  GetScroreCardResponse({this.success, this.msg, this.scorecard});

  GetScroreCardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    scorecard = json['scorecard'] != null
        ? new Scorecard.fromJson(json['scorecard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.scorecard != null) {
      data['scorecard'] = this.scorecard!.toJson();
    }
    return data;
  }
}

class Scorecard {
  Exam? exam;
  int? correctAnswerCount;
  int? fillUpCount;
  int? chooseOneCount;
  int? oneWordCount;
  int? trueFalseCount;
  int? matchFollowingCount;

  Scorecard(
      {this.exam,
        this.correctAnswerCount,
        this.fillUpCount,
        this.chooseOneCount,
        this.oneWordCount,
        this.trueFalseCount,
        this.matchFollowingCount});

  Scorecard.fromJson(Map<String, dynamic> json) {
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
    correctAnswerCount = json['correct_answer_count'];
    fillUpCount = json['fill_up_count'];
    chooseOneCount = json['choose_one_count'];
    oneWordCount = json['one_word_count'];
    trueFalseCount = json['true_false_count'];
    matchFollowingCount = json['match_following_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exam != null) {
      data['exam'] = this.exam!.toJson();
    }
    data['correct_answer_count'] = this.correctAnswerCount;
    data['fill_up_count'] = this.fillUpCount;
    data['choose_one_count'] = this.chooseOneCount;
    data['one_word_count'] = this.oneWordCount;
    data['true_false_count'] = this.trueFalseCount;
    data['match_following_count'] = this.matchFollowingCount;
    return data;
  }
}

class Exam {
  int? id;
  String? uuid;
  int? studentId;
  int? total;
  int? status;
  String? createdAt;
  String? updatedAt;

  Exam(
      {this.id,
        this.uuid,
        this.studentId,
        this.total,
        this.status,
        this.createdAt,
        this.updatedAt});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    studentId = json['student_id'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['student_id'] = this.studentId;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}