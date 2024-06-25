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
		user = json['user'] != null ? new User.fromJson(json['user']) : null;
		student = json['student'] != null ? new Student.fromJson(json['student']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		data['msg'] = this.msg;
		data['token'] = this.token;
		if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
		if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
		return data;
	}
}

