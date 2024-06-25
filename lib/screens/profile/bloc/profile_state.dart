import '../../../api/base_equatable.dart';

class ProfileScreenState extends BaseEquatable {}

class ProfileScreenInitaialState extends ProfileScreenState {
  @override
  bool operator ==(Object other) => false;
}

class ProfilePasswordVisibilityChangedState extends ProfileScreenState {
  @override
  bool operator ==(Object other) => false;
}

class ProfileScreenLoadingCompletedState extends ProfileScreenState {
  @override
  bool operator ==(Object other) => false;
}

class ProfileScreenErrorState extends ProfileScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  ProfileScreenErrorState(this.error);
  @override
  String toString() {
    return 'ProfileScreenErrorState';
  }
}

class ProfileScreenLoadingState extends ProfileScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ProfileScreenLoadingState';
  }
}

class ProfileScreenSuccessState extends ProfileScreenState {
  String? message;
  ProfileScreenSuccessState({this.message});
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ProfileScreenSuccessState';
  }
}
class NavigateToHomeScreenState extends ProfileScreenState {

  NavigateToHomeScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToHomeScreenState';
  }
}
