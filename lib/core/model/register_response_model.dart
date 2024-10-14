import 'login/student_model.dart';

class RegisterResponseModel {
	int? success;
	String? msg;
	Student? student;

	RegisterResponseModel({this.success, this.msg, this.student});

	RegisterResponseModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		msg = json['msg'];
		student = json['student'] != null ? Student.fromJson(json['student']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['success'] = success;
		data['msg'] = msg;
		if (student != null) {
      data['student'] = student!.toJson();
    }
		return data;
	}
}