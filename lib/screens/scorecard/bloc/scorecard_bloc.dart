import 'package:EPW_mobile/screens/login/usecase/login_usecase.dart';
import '../../../api/interface/login/login_response.dart';
import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import '../usecase/get_scorecard_response.dart';
import 'Scorecard_event.dart';
import 'Scorecard_state.dart';

class ScorecardScreenBloc extends Bloc<ScorecardScreenEvent, ScorecardScreenState> {

  final AppPreferences appPreferences;
  final GetScoreCardUseCase getScoreCardUseCase;


  LoginResponseModel? loginResponseModel;
  late BuildContext context;
  bool? languageValue;
  int? answerCount;
  String? diaAbilityType;


  ScorecardScreenBloc({required this.getScoreCardUseCase, required this.appPreferences})
      : super(ScorecardScreenInitaialState()) {
    on<ScorecardScreenInitialEvent>(onScorecardScreenInitialEvent);
    on<ScorecardScreenScorecardButtonClickEvent>(onScorecardScreenScorecardButtonClickEvent);
   // add(ScorecardScreenInitialEvent());
  }


  Future<void> onScorecardScreenInitialEvent(
    ScorecardScreenInitialEvent event,
    Emitter<ScorecardScreenState> emit,
  ) async {

    loginResponseModel = await appPreferences.getUser();
    diaAbilityType = loginResponseModel != null && loginResponseModel!.student!=null
        && loginResponseModel!.student!.disablityType != null ? loginResponseModel!.student!.disablityType : null;

    emit(ScorecardScreenLoadingState());
     final response = await getScoreCardUseCase.call(
        params:  GetScoreCardParams(examId: event.examId));

    response.fold(
        (l) => {emit(ScorecardScreenErrorState(l.toString()))},
        (r) => {
         answerCount =   r.scorecard!.correctAnswerCount,
              emit(ScorecardScreenSuccessState())
            });
      emit(ScorecardScreenLoadingCompletedState());
  }


 Future<void> onScorecardScreenScorecardButtonClickEvent(
    ScorecardScreenScorecardButtonClickEvent event,
    Emitter<ScorecardScreenState> emit,
  ) async {
     

  }

 

  clear() async{
   await appPreferences.clearStorage();
  }
}
