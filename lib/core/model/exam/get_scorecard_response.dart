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
        ? Scorecard.fromJson(json['scorecard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['msg'] = msg;
    if (scorecard != null) {
      data['scorecard'] = scorecard!.toJson();
    }
    return data;
  }
}