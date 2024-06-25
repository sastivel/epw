import '../../../api/base_equatable.dart';

class LoginScreenEvent extends BaseEquatable {}

class LoginScreenInitialEvent extends LoginScreenEvent {}

class LoginScreenLoginButtonClickEvent extends LoginScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class LoginScreenSuccessEvent extends LoginScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class LoginPasswordVisibilityChangedEvent extends LoginScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class LoginScreenErrorEvent extends LoginScreenEvent {
  final String? error;
  LoginScreenErrorEvent(this.error);
}

class LoginScreenLanguageChangeEvent extends LoginScreenEvent {
  final bool? value;
  LoginScreenLanguageChangeEvent(this.value);
}
