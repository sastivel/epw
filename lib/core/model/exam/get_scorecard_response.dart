import 'package:EPW_mobile/core/model/exam/scorecard.dart';

class GetScroreCardResponse {
  int? success;
  String? msg;
  Scorecard? scorecard;

  GetScroreCardResponse({this.success, this.msg, this.scorecard});

  GetScroreCardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    scorecard = json['scorecard'] != null
        ? new Scorecard.fromJson(json['scorecard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.scorecard != null) {
      data['scorecard'] = this.scorecard!.toJson();
    }
    return data;
  }
}