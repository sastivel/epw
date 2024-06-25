import 'package:EPW_mobile/screens/exam/usecase/get_exam_id_usecase.dart';
import 'package:EPW_mobile/screens/login/usecase/login_usecase.dart';
import '../../../api/interface/login/login_response.dart';
import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import 'exam_event.dart';
import 'exam_state.dart';

class ExamScreenBloc extends Bloc<ExamScreenEvent, ExamScreenState> {

  final AppPreferences appPreferences;
  final GetExamIdUseCase examIdUseCase;
  TextEditingController mobileNumberController = TextEditingController();

  LoginResponseModel? loginResponseModel;
  late BuildContext context;
  bool? languageValue;
   int? examId;
 

  ExamScreenBloc({required this.examIdUseCase, required this.appPreferences})
      : super(ExamScreenInitaialState()) {
    on<ExamScreenInitialEvent>(onExamScreenInitialEvent);
    on<ExamScreenExamButtonClickEvent>(onExamScreenExamButtonClickEvent);
    add(ExamScreenInitialEvent());
  }


  Future<void> onExamScreenInitialEvent(
    ExamScreenInitialEvent event,
    Emitter<ExamScreenState> emit,
  ) async {
    emit(ExamScreenLoadingState());
    languageValue = appPreferences.getLanguageCode();
    loginResponseModel = await appPreferences.getUser();
    emit(ExamScreenLoadingCompletedState());
  }


 Future<void> onExamScreenExamButtonClickEvent(
    ExamScreenExamButtonClickEvent event,
    Emitter<ExamScreenState> emit,
  ) async {
      emit(ExamScreenLoadingState());
     final response = await examIdUseCase.call(
        params: GetExamIdParams(studentId:loginResponseModel?.student?.id));

    response.fold(
        (l) => {emit(ExamScreenErrorState(l.toString()))},
        (r) => {
              emit(ExamScreenSuccessState(examId: r.exam!.id))
            });
      emit(ExamScreenLoadingCompletedState());

  }

 

  clear() async{
   await appPreferences.clearStorage();
  }
}
