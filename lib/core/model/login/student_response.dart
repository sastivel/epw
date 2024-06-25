import 'package:EPW_mobile/core/model/login/student_model.dart';

class StudentResponse {
  int? success;
  String? msg;
  List<Student>? students;

  StudentResponse({this.success, this.msg, this.students});

  StudentResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['students'] != null) {
      students = <Student>[];
      json['students'].forEach((v) {
        students!.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}