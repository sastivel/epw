// ignore_for_file: prefer_collection_literals

import '../../../core/model/login/student_model.dart';
import '../../../core/model/login/user_model.dart';

class LoginResponseModel {
	int? success;
	String? msg;
	String? token;
	User? user;
	Student? student;

	LoginResponseModel({this.success, this.msg, this.token, this.user, this.student});

	LoginResponseModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		msg = json['msg'];
		token = json['token'];
		user = json['user'] != null ? User.fromJson(json['user']) : null;
		student = json['student'] != null ? Student.fromJson(json['student']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['success'] = success;
		data['msg'] = msg;
		data['token'] = token;
		if (user != null) {
      data['user'] = user!.toJson();
    }
		if (student != null) {
      data['student'] = student!.toJson();
    }
		return data;
	}
}

