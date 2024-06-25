import '../../../api/base_equatable.dart';

class LoginScreenState extends BaseEquatable {}

class LoginScreenInitaialState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
}

class LoginPasswordVisibilityChangedState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
}

class LoginScreenLoadingCompletedState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
}

class LoginScreenErrorState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  LoginScreenErrorState(this.error);
  @override
  String toString() {
    return 'LoginScreenErrorState';
  }
}

class LoginScreenLoadingState extends LoginScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'LoginScreenLoadingState';
  }
}

class LoginScreenSuccessState extends LoginScreenState {

  @override
  bool operator ==(Object other) => false;
  
  @override
  String toString() {
    return 'LoginScreenSuccessState';
  }
}
class NavigateToHomeScreenState extends LoginScreenState {

  NavigateToHomeScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToHomeScreenState';
  }
}
