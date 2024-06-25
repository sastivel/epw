import 'dart:core';

class Student {
  String? uuid;
  int? userId;
  String? name;
  String? className;
  String? disablityType;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Student(
      {this.uuid,
      this.userId,
      this.name,
      this.className,
      this.disablityType,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Student.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    name = json['name'];
    className = json['class_name'];
    disablityType = json['disability_type'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['class_name'] = this.className;
    data['status'] = this.status;
    data['disability_type'] = this.disablityType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
