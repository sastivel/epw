import '../../../api/base_equatable.dart';

class HomeScreenState extends BaseEquatable {}

class HomeScreenInitaialState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomePasswordVisibilityChangedState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
}



class HomeScreenLoadingCompletedState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomeScreenErrorState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  HomeScreenErrorState(this.error);
  @override
  String toString() {
    return 'HomeScreenErrorState';
  }
}

class HomeScreenLoadingState extends HomeScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'HomeScreenLoadingState';
  }
}

class HomeScreenSuccessState extends HomeScreenState {

  @override
  bool operator ==(Object other) => false;
  
  @override
  String toString() {
    return 'HomeScreenSuccessState';
  }
}
class NavigateToHomeScreenState extends HomeScreenState {

  NavigateToHomeScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToHomeScreenState';
  }
}
