import 'login/student_model.dart';

class RegisterResponseModel {
	int? success;
	String? msg;
	Student? student;

	RegisterResponseModel({this.success, this.msg, this.student});

	RegisterResponseModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		msg = json['msg'];
		student = json['student'] != null ? new Student.fromJson(json['student']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		data['msg'] = this.msg;
		if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
		return data;
	}
}