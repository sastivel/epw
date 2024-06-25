import '../../../api/base_equatable.dart';

class RegisterScreenState extends BaseEquatable {}

class RegisterScreenInitaialState extends RegisterScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisterPasswordVisibilityChangedState extends RegisterScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisterScreenLoadingCompletedState extends RegisterScreenState {
  @override
  bool operator ==(Object other) => false;
}

class RegisterScreenErrorState extends RegisterScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  RegisterScreenErrorState(this.error);
  @override
  String toString() {
    return 'RegisterScreenErrorState';
  }
}

class RegisterScreenLoadingState extends RegisterScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'RegisterScreenLoadingState';
  }
}

class RegisterScreenSuccessState extends RegisterScreenState {
  String? message;
  RegisterScreenSuccessState({this.message});
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'RegisterScreenSuccessState';
  }
}
class NavigateToHomeScreenState extends RegisterScreenState {

  NavigateToHomeScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToHomeScreenState';
  }
}
