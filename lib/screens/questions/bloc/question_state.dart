import '../../../api/base_equatable.dart';

class QuestionsScreenState extends BaseEquatable {}

class QuestionsScreenInitaialState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
}

class HomePasswordVisibilityChangedState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
}



class QuestionsScreenLoadingCompletedState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
}

class QuestionsScreenErrorState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
  final String? error;
  QuestionsScreenErrorState(this.error);
  @override
  String toString() {
    return 'QuestionsScreenErrorState';
  }
}

class QuestionsScreenLoadingState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'QuestionsScreenLoadingState';
  }
}

class QuestionsScreenSuccessState extends QuestionsScreenState {

  @override
  bool operator ==(Object other) => false;
  
  @override
  String toString() {
    return 'QuestionsScreenSuccessState';
  }
}
class NavigateToQuestionsScreenState extends QuestionsScreenState {

  NavigateToQuestionsScreenState();
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'NavigateToQuestionsScreenState';
  }
}

  class QuestionsScreenBtnLoadingState extends QuestionsScreenState {
  @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'QuestionsScreenBtnLoadingState';
  }
}


class MoveToScoreCardState extends QuestionsScreenState {
   @override
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'QuestionsScreenBtnLoadingState';
  }
}



