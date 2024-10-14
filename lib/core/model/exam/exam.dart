// ignore_for_file: prefer_collection_literals

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uuid'] = uuid;
    data['student_id'] = studentId;
    data['total'] = total;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}