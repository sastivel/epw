import '../../../api/base_equatable.dart';
import '../../../utils/common_imports.dart';

class QuestionsScreenEvent extends BaseEquatable {}

class QuestionsScreenInitialEvent extends QuestionsScreenEvent {
  int? examId;
  Locale? locale;
  QuestionsScreenInitialEvent({this.examId,this.locale});
    @override
  bool operator ==(Object other) => false;
}

class QuestionsScreenQuestionsButtonClickEvent extends QuestionsScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class QuestionsScreenSuccessEvent extends QuestionsScreenEvent {
  @override
  bool operator ==(Object other) => false;
}


class QuestionsScreenErrorEvent extends QuestionsScreenEvent {
  final String? error;
  QuestionsScreenErrorEvent(this.error);
}

class QuestionsScreenLanguageChangeEvent extends QuestionsScreenEvent {
  final bool? value;
  QuestionsScreenLanguageChangeEvent(this.value);
}

class AnswerSelectEvent extends QuestionsScreenEvent {
  final int? index;
  final String? answer;
  AnswerSelectEvent({this.index,this.answer});
}

class QuestionSubmitEvent extends QuestionsScreenEvent {
  QuestionSubmitEvent();
}

class MoveToScoreCardEvent extends QuestionsScreenEvent {
  MoveToScoreCardEvent();
}

class GetMatchQuestionEvent extends QuestionsScreenEvent {
  GetMatchQuestionEvent();
}

class MatchOptionRearranegEvent extends QuestionsScreenEvent {
  int oldIndex,newIndex;
  MatchOptionRearranegEvent({required this.oldIndex,required this.newIndex});
}

class MatchSubmitEvent extends QuestionsScreenEvent {
  MatchSubmitEvent();
}


