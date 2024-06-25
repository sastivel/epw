import '../../../api/base_equatable.dart';

class ScorecardScreenEvent extends BaseEquatable {}

class ScorecardScreenInitialEvent extends ScorecardScreenEvent {
  final int? examId;
  ScorecardScreenInitialEvent({required this.examId});
  
}

class ScorecardScreenScorecardButtonClickEvent extends ScorecardScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class ScorecardScreenSuccessEvent extends ScorecardScreenEvent {
  @override
  bool operator ==(Object other) => false;
}


class ScorecardScreenErrorEvent extends ScorecardScreenEvent {
  final String? error;
  ScorecardScreenErrorEvent(this.error);
}

class ScorecardScreenLanguageChangeEvent extends ScorecardScreenEvent {
  final bool? value;
  ScorecardScreenLanguageChangeEvent(this.value);
}
