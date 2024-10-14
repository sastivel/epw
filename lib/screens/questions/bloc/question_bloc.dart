import 'dart:async';

import 'package:EPW_mobile/core/model/exam/match_question_response.dart';
import 'package:EPW_mobile/screens/login/usecase/login_usecase.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_event.dart';
import 'package:EPW_mobile/screens/questions/bloc/question_state.dart';
import 'package:EPW_mobile/screens/questions/usecase/post_match_answer_usecase.dart';
import '../../../api/interface/login/login_response.dart';
import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import '../usecase/get_match_question_response.dart';
import '../usecase/get_question_response.dart';
import '../usecase/post_answer_usecase.dart';

class QuestionsScreenBloc
    extends Bloc<QuestionsScreenEvent, QuestionsScreenState> {
  final AppPreferences appPreferences;
  final GetQuestionUseCase getQuestionUseCase;
  final PostAnswerUseCase postAnswerUseCase;
  final GetMatchQuestionUseCase getMatchQuestionUseCase;
  final PostMatchAnswerUseCase postMatchAnswerUseCase;
  TextEditingController mobileNumberController = TextEditingController();

  LoginResponseModel? loginResponseModel;
  late BuildContext context;
  bool? languageValue;
  String? currentQuestion;
  List<String>? currentOptions;
  String? currentQuestionAnswer;
  int? currentQuestionType;
  bool isLastQuestion = false;
  int? selectedAnswerIndex;
  int? currentQuestionAnswerIndex;
  String? selectedAnswer;
  bool isCurrentQuestionSubmitted = false;
  bool isMatchQuestionSubmitted = false;
  int? currentQuestionId;
  int? examId;
  TextEditingController fillInTheBlanksController = TextEditingController();
  List<String?> matchQuestion = [];
  List<String?> matchAnswer = [];
  List<String?> matchOptions = [];
  List<int?> matchQuestionIds = [];
  String? disAbilityType;

  QuestionsScreenBloc(
      {required this.getQuestionUseCase,
      required this.postAnswerUseCase,
      required this.getMatchQuestionUseCase,
      required this.postMatchAnswerUseCase,
      required this.appPreferences})
      : super(QuestionsScreenInitaialState()) {
    on<QuestionsScreenInitialEvent>(onQuestionsScreenInitialEvent);
    on<AnswerSelectEvent>(onAnswerSelectEvent);
    on<QuestionSubmitEvent>(onQuestionSubmitEvent);
    on<MoveToScoreCardEvent>(onMoveToScoreCardEvent);
    on<GetMatchQuestionEvent>(onGetMatchQuestionEvent);
    on<MatchOptionRearranegEvent>(onMatchOptionRearranegEvent);
    on<MatchSubmitEvent>(onMatchSubmitEvent);
  }

  Future<void> onQuestionsScreenInitialEvent(
    QuestionsScreenInitialEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    examId = event.examId;
    if (examId == null) {
      return emit(QuestionsScreenErrorState('Invalid exam id '));
    }

    emit(QuestionsScreenLoadingState());
    clear();
    languageValue = appPreferences.getLanguageCode();
    loginResponseModel = await appPreferences.getUser();
    disAbilityType = loginResponseModel != null && loginResponseModel!.student!=null
        && loginResponseModel!.student!.disablityType != null ? loginResponseModel!.student!.disablityType : null;

    final response = await getQuestionUseCase.call(
        params: GetQuestionParams(examId: event.examId!));

    response.fold(
        (l) => {emit(QuestionsScreenErrorState(l.toString()))},
        (r) => {
              currentQuestionType = int.parse(r.question!.type!),
              if (languageValue == true)
                {
                  if (r.question == null)
                    {emit(QuestionsScreenErrorState('Invalid Question'))},
                  if (r.question?.questionTamil == null)
                    {emit(QuestionsScreenErrorState('Invalid Question'))}
                  else
                    {
                      currentQuestion = r.question?.questionTamil,
                      currentQuestionId = r.question?.id
                    },
                  if (r.question?.optionsTamil == null)
                    {emit(QuestionsScreenErrorState('Invalid options'))}
                  else
                    {
                      if (currentQuestionType == 3)
                        {
                          currentOptions!.addAll(["ஆம்", "இல்லை"]),
                        }
                      else
                        {
                          currentOptions = r.question?.optionsTamil,
                        }
                    },
                  if (r.question?.answer == null)
                    {emit(QuestionsScreenErrorState('Invalid answer'))}
                  else
                    {currentQuestionAnswer = r.question?.answerTamil},
                }
              else
                {
                  if (r.question == null)
                    {emit(QuestionsScreenErrorState('Invalid Question'))},
                  if (r.question?.question == null)
                    {emit(QuestionsScreenErrorState('Invalid Question'))}
                  else
                    {
                      currentQuestion = r.question?.question,
                      currentQuestionId = r.question?.id
                    },
                  if (r.question?.options == null)
                    {emit(QuestionsScreenErrorState('Invalid options'))}
                  else
                    {
                      if (currentQuestionType == 3)
                        {
                          currentOptions!.addAll(["true", "false"]),
                        }
                      else
                        {
                          currentOptions = r.question?.options,
                        }
                    },
                  if (r.question?.answer == null)
                    {emit(QuestionsScreenErrorState('Invalid answer'))}
                  else
                    {currentQuestionAnswer = r.question?.answer},
                },
              if (r.isLastQuestion == null)
                {isLastQuestion = true}
              else
                {isLastQuestion = r.isLastQuestion!},
              emit(QuestionsScreenSuccessState())
            });
    emit(QuestionsScreenLoadingCompletedState());
  }

  Future<void> onAnswerSelectEvent(
    AnswerSelectEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    selectedAnswer = event.answer;
    selectedAnswerIndex = event.index;
    emit(QuestionsScreenLoadingCompletedState());
  }

  Future<void> onMoveToScoreCardEvent(
    MoveToScoreCardEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    emit(MoveToScoreCardState());
  }

  Future<void> onQuestionSubmitEvent(
    QuestionSubmitEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    emit(QuestionsScreenBtnLoadingState());

    if ((currentQuestionType == 1 || currentQuestionType == 3) &&
        (selectedAnswer == null || selectedAnswerIndex == null)) {
      return emit(QuestionsScreenErrorState('Please choose the answer'));
    }
    if ((currentQuestionType == 0 || currentQuestionType == 2) &&
        fillInTheBlanksController.text.isEmpty == true) {
      return emit(QuestionsScreenErrorState('Please choose the answer'));
    }
    final response = await postAnswerUseCase.call(
        params: PostAnswerParams(
            examId: examId!,
            answer: (currentQuestionType == 0 || currentQuestionType == 2)
                ? fillInTheBlanksController.text
                : selectedAnswer!,
            language: languageValue == true ? "Tamil" : "English",
            questionId: currentQuestionId!));

    response.fold(
        (l) => {emit(QuestionsScreenErrorState(l.toString()))},
        (r) => {
              print(r.msg),
              isCurrentQuestionSubmitted = true,
              if (currentQuestionType == 1 || currentQuestionType == 3)
                {
                  currentQuestionAnswerIndex = currentOptions!
                      .indexWhere((data) => data == currentQuestionAnswer),
                  emit(QuestionsScreenSuccessState())
                },
              if (currentQuestionType == 0 || currentQuestionType == 2)
                {emit(QuestionsScreenSuccessState())}
            });
  }

  Future<void> onGetMatchQuestionEvent(
    GetMatchQuestionEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    emit(QuestionsScreenLoadingState());
    final response = await getMatchQuestionUseCase.call(
        params: MatcQuestionParams(examId: examId!));

    response.fold(
        (l) => {emit(QuestionsScreenErrorState(l.toString()))},
        (r) => {
              if (r.question != null && r.question!.length > 0)
                {
                  currentQuestionType = int.parse(r.question![0].type!),
                  matchQuestionIds = r.question!.map((e) => e.id).toList(),
                  if (languageValue == true)
                    {
                      matchQuestion =
                          r.question!.map((e) => e.questionTamil).toList(),
                      matchOptions =
                          r.question!.map((e) => e.optionsTamil![0]).toList(),
                      matchAnswer =
                          r.question!.map((e) => e.answerTamil).toList(),
                    }
                  else
                    {
                      matchQuestion =
                          r.question!.map((e) => e.question).toList(),
                      matchOptions =
                          r.question!.map((e) => e.options![0]).toList(),
                      matchAnswer = r.question!.map((e) => e.answer).toList()
                    }
                }
            });
    emit(QuestionsScreenLoadingCompletedState());
  }

  Future<void> onMatchOptionRearranegEvent(
    MatchOptionRearranegEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    if (event.oldIndex < event.newIndex) {
      event.newIndex -= 1;
    }
    final String? item = matchOptions.removeAt(event.oldIndex);
    matchOptions.insert(event.newIndex, item);

    emit(QuestionsScreenLoadingCompletedState());
  }

  Future<void> onMatchSubmitEvent(
    MatchSubmitEvent event,
    Emitter<QuestionsScreenState> emit,
  ) async {
    emit(QuestionsScreenBtnLoadingState());
    final response = await postMatchAnswerUseCase.call(
        params: PostMatchAnswerParams(
            examId: examId!,
            answers: matchOptions.join(','),
            language: languageValue == true ? "Tamil" : "English",
            questionIds: matchQuestionIds.join(',')));

    response.fold(
        (l) => {emit(QuestionsScreenErrorState(l.toString()))},
        (r) => {
              isMatchQuestionSubmitted = true
              //emit(MoveToScoreCardState())
            });

    emit(QuestionsScreenLoadingCompletedState());
  }

  clear() async {
    selectedAnswer = null;
    selectedAnswerIndex = null;
    currentQuestion = null;
    currentOptions = [];
    currentQuestionAnswer = null;
    currentQuestionType = null;
    isLastQuestion = false;
    isCurrentQuestionSubmitted = false;
    currentQuestionId = null;
    currentQuestionAnswerIndex = null;
    isMatchQuestionSubmitted = false;
    fillInTheBlanksController.clear();
  }

  isCorrectAnswer(index) {
    return matchOptions[index] == matchAnswer[index] ? true : false;
  }
}
