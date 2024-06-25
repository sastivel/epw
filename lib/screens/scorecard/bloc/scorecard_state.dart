import '../../../api/base_equatable.dart';

class ScorecardScreenState extends BaseEquatable {}

class ScorecardScreenInitaialState extends ScorecardScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomePasswordVisibilityChangedState extends ScorecardScreenState {
  @override
  bool operator ==(Object other) => false;
}



class ScorecardScreenLoadingCompletedState extends ScorecardScreenState {
  @override
  bool operator ==(Object other) => false;
}

class ScorecardScreenErrorState extends ScorecardScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  ScorecardScreenErrorState(this.error);
  @override
  String toString() {
    return 'ScorecardScreenErrorState';
  }
}

class ScorecardScreenLoadingState extends ScorecardScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ScorecardScreenLoadingState';
  }
}

class ScorecardScreenSuccessState extends ScorecardScreenState {

  @override
  bool operator ==(Object other) => false;
  
  @override
  String toString() {
    return 'ScorecardScreenSuccessState';
  }
}
class NavigateToScorecardScreenState extends ScorecardScreenState {

  NavigateToScorecardScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToScorecardScreenState';
  }
}
