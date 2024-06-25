import '../../../api/base_equatable.dart';

class ExamScreenEvent extends BaseEquatable {}

class ExamScreenInitialEvent extends ExamScreenEvent {}

class ExamScreenExamButtonClickEvent extends ExamScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class ExamScreenSuccessEvent extends ExamScreenEvent {
  @override
  bool operator ==(Object other) => false;
}


class ExamScreenErrorEvent extends ExamScreenEvent {
  final String? error;
  ExamScreenErrorEvent(this.error);
}

class ExamScreenLanguageChangeEvent extends ExamScreenEvent {
  final bool? value;
  ExamScreenLanguageChangeEvent(this.value);
}
