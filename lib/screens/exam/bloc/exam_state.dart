
import '../../../api/base_equatable.dart';

class ExamScreenState extends BaseEquatable {}

class ExamScreenInitaialState extends ExamScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomePasswordVisibilityChangedState extends ExamScreenState {
  @override
  bool operator ==(Object other) => false;
}



class ExamScreenLoadingCompletedState extends ExamScreenState {
  @override
  bool operator ==(Object other) => false;
}

class ExamScreenErrorState extends ExamScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  ExamScreenErrorState(this.error);
  @override
  String toString() {
    return 'ExamScreenErrorState';
  }
}

class ExamScreenLoadingState extends ExamScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ExamScreenLoadingState';
  }
}

class ExamScreenSuccessState extends ExamScreenState {
 int? examId;
 ExamScreenSuccessState({this.examId});
  @override
  bool operator ==(Object other) => false;
  
  @override
  String toString() {
    return 'ExamScreenSuccessState';
  }
}
class NavigateToExamScreenState extends ExamScreenState {

  NavigateToExamScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToExamScreenState';
  }
}
