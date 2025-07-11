
import '../../../api/interface/login/login_response.dart';
import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/validator.dart';
import '../usecase/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUseCase loginUseCase;
  final AppPreferences appPreferences;
  TextEditingController mobileNumberController = TextEditingController();

  LoginResponseModel? loginResponse;
  late BuildContext context;
  bool? languageValue;

  LoginScreenBloc({required this.loginUseCase, required this.appPreferences})
      : super(LoginScreenInitaialState()) {
    on<LoginScreenInitialEvent>(onLoginScreenInitialEvent);
    on<LoginScreenLoginButtonClickEvent>(onLoginScreenLoginButtonClickEvent);
    on<LoginScreenLanguageChangeEvent>(onLoginScreenLanguageChangeEvent);
    add(LoginScreenInitialEvent());
  }

  Future<void> onLoginScreenInitialEvent(
    LoginScreenInitialEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    languageValue = await appPreferences.getLanguageCode();

    //  AppUtils.isLoggedIn = false;
    // emit(LoginScreenLoadingState());
    emit(LoginScreenLoadingCompletedState());
    LoginResponseModel? res = await appPreferences.getUser();
    print('login res --->> ${res}');
    if (res != null &&
        res.token?.isNotEmpty == true &&
        res.student != null &&
        res.student?.id != null) {
      // print('yessss');
      // emit(LoginScreenLoadingCompletedState());

      return emit(NavigateToHomeScreenState());
    } else {
      mobileNumberController.clear();
      await appPreferences.clearStorage();
      emit(LoginScreenLoadingCompletedState());
    }
  }

  Future<void> onLoginScreenLanguageChangeEvent(
    LoginScreenLanguageChangeEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    //  AppUtils.isLoggedIn = false;
    emit(LoginScreenLoadingState());
    languageValue = event.value;
    appPreferences.saveLanguageCode(event.value!);
    emit(LoginScreenLoadingCompletedState());
  }

  Future<void> onLoginScreenLoginButtonClickEvent(
    LoginScreenLoginButtonClickEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    // emit(NavigateToHomeScreenState());
    ValidationState state;
    state =
        Validator.validate(mobileNumberController.text, rules: ['required']);
    if (!state.status) {
      emit(
        LoginScreenErrorState(
          '${state.error}',
        ),
      );
      return;
    }

    state = Validator.validate(mobileNumberController.text, rules: ['min:10']);
    if (!state.status) {
      emit(
        LoginScreenErrorState(
          '${state.error}',
        ),
      );
      return;
    }

    emit(LoginScreenLoadingState());
    final response = await loginUseCase.call(
        params: LoginParams(mobile: mobileNumberController.text));

    response.fold(
        (l) => {emit(LoginScreenErrorState(l.toString()))},
        (r) => {
              print("***************loginResponseModel******"),
              print(r.student!.toJson()),
              appPreferences.setUser(r),
              if (r.student != null && r.student?.id != null)
                {emit(NavigateToHomeScreenState())}
              else
                {emit(LoginScreenSuccessState())}
            });
  }

  clear() async {
    await appPreferences.clearStorage();
  }
}
