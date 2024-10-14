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
        students!.add(Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}