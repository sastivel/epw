
// ignore_for_file: prefer_collection_literals

class BaseAddAnswerResponse {
  int? success;
  String? msg;
  

  BaseAddAnswerResponse({this.success, this.msg});

  BaseAddAnswerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    return data;
  }
}