class User {
	int? id;
	String? mobile;
	int? status;

	User({this.id, this.mobile, this.status});

	User.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		mobile = json['mobile'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['id'] = id;
		data['mobile'] = mobile;
		data['status'] = status;
		return data;
	}
}