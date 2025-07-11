import 'package:EPW_mobile/screens/home/bloc/home_event.dart';
import 'package:EPW_mobile/screens/home/usecase/student_usecase.dart';
import 'package:EPW_mobile/screens/login/usecase/login_usecase.dart';

import '../../../api/interface/login/login_response.dart';
import '../../../core/model/login/student_model.dart';
import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';

import 'Home_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final LoginUseCase loginUseCase;
  final AppPreferences appPreferences;
  TextEditingController mobileNumberController = TextEditingController();

  LoginResponseModel? loginResponseModel;
  late BuildContext context;
  bool? languageValue;
  List<Student>? studentList;
  StudentUseCase studentUseCase;
  Student? selectedStudent;

  HomeScreenBloc(
      {required this.loginUseCase,
      required this.appPreferences,
      required this.studentUseCase})
      : super(HomeScreenInitaialState()) {
    on<HomeScreenInitialEvent>(onHomeScreenInitialEvent);
    on<HomeScreenLanguageChangeEvent>(onHomeScreenLanguageChangeEvent);
    on<HomeScreenSelectStudentEvent>(onHomeScreenSelectStudentEvent);

    add(HomeScreenInitialEvent());
  }

  Future<void> onHomeScreenInitialEvent(
    HomeScreenInitialEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(HomeScreenLoadingState());
    languageValue = appPreferences.getLanguageCode();
    print('*************languagecode**********');
    print(languageValue);
    studentList = [];
    loginResponseModel = await appPreferences.getUser();
    print(
        '***************print************${loginResponseModel?.user?.toJson()}');

    if (loginResponseModel?.student != null) {
      selectedStudent = loginResponseModel?.student;
    }

    final response = await studentUseCase.call(params: StudentListParams());

    response.fold(
        (l) => {emit(HomeScreenErrorState(l.toString()))},
        (r) => {
              if (r.students != null && r.students!.isNotEmpty)
                {
                  studentList = r.students,
                }
            });
    emit(HomeScreenLoadingCompletedState());
  }

  Future<void> onHomeScreenLanguageChangeEvent(
    HomeScreenLanguageChangeEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    //  AppUtils.isLoggedIn = false;
    // emit(HomeScreenLoadingState());
    languageValue = event.value;
    appPreferences.saveLanguageCode(event.value!);
    emit(HomeScreenLoadingCompletedState());
  }

  Future<void> onHomeScreenSelectStudentEvent(
    HomeScreenSelectStudentEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    selectedStudent = event.student;
    loginResponseModel!.student = selectedStudent;
    appPreferences.setUser(loginResponseModel!);
    emit(HomeScreenLoadingCompletedState());
  }

  clear() async {
    await appPreferences.clearStorage();
  }
}
