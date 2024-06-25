class Exam {
  String? uuid;
  int? studentId;
  int? total;
  String? updatedAt;
  String? createdAt;
  int? id;

  Exam(
      {this.uuid,
      this.studentId,
      this.total,
      this.updatedAt,
      this.createdAt,
      this.id});

  Exam.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    studentId = json['student_id'];
    total = json['total'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['student_id'] = this.studentId;
    data['total'] = this.total;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}