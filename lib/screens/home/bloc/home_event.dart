import '../../../api/base_equatable.dart';
import '../../../core/model/login/student_model.dart';

class HomeScreenEvent extends BaseEquatable {}

class HomeScreenInitialEvent extends HomeScreenEvent {}

class HomeScreenHomeButtonClickEvent extends HomeScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class HomeScreenSelectStudentEvent extends HomeScreenEvent {
  final Student? student;
  HomeScreenSelectStudentEvent(this.student);
  @override
  bool operator ==(Object other) => false;
}

class HomeScreenSuccessEvent extends HomeScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class HomePasswordVisibilityChangedEvent extends HomeScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class HomeScreenErrorEvent extends HomeScreenEvent {
  final String? error;
  HomeScreenErrorEvent(this.error);
}

class HomeScreenLanguageChangeEvent extends HomeScreenEvent {
  final bool? value;
  HomeScreenLanguageChangeEvent(this.value);
}


