import 'package:EPW_mobile/api/interface/base/base_response.dart';
import 'package:EPW_mobile/api/interface/login/login_response.dart';
import 'package:EPW_mobile/screens/register/bloc/register_event.dart';
import 'package:EPW_mobile/screens/register/bloc/register_state.dart';
import 'package:EPW_mobile/screens/profile/bloc/profile_event.dart';
import 'package:EPW_mobile/screens/profile/bloc/profile_state.dart';

import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/validator.dart';
import '../usecase/register_usecase.dart';

class RegisterScreenBloc
    extends Bloc<RegisterScreenEvent, RegisterScreenState> {
  final RegisterUseCase registerUseCase;
  final AppPreferences appPreferences;
  TextEditingController nameTextController = TextEditingController();

  BaseResponse? baseResponse;
  late BuildContext context;
  String? selectedClassName;
  String? selectedDisablityType;
  String? isChildDisablity;
  LoginResponseModel? loginResponseModel;
  RegisterScreenBloc(
      {required this.registerUseCase, required this.appPreferences})
      : super(RegisterScreenInitaialState()) {
    on<RegisterScreenInitialEvent>(onRegisterScreenInitialEvent);
    on<RegisterScreenDropDownEvent>(onRegisterScreenDropDownEvent);
    on<RegisterScreenDisablityDropDownEvent>(
        onRegisterScreenDisablityDropDownEvent);
    on<RegisterScreenRegisterButtonClickEvent>(
        onRegisterScreenRegisterButtonClickEvent);
    on<RegisterScreenDisablityStatusDropDownEvent>(
        onRegisterScreenDisablityStatusDropDownEvent);
    add(RegisterScreenInitialEvent());
  }

  Future<void> onRegisterScreenInitialEvent(
    RegisterScreenInitialEvent event,
    Emitter<RegisterScreenState> emit,
  ) async {
    //  AppUtils.isLoggedIn = false;
    selectedClassName = '6';
    selectedDisablityType = "Visual Impairment";
    isChildDisablity = "No";
    loginResponseModel = await appPreferences.getUser();
    print("***************loginResponseModel******");
    print(loginResponseModel!.student!.toJson());
    emit(RegisterScreenLoadingState());
    emit(RegisterScreenLoadingCompletedState());
  }

  Future<void> onRegisterScreenDropDownEvent(RegisterScreenDropDownEvent event,
      Emitter<RegisterScreenState> emit) async {
    selectedClassName = event.selectedValue;
    emit(RegisterScreenLoadingCompletedState());
    return;
  }

  Future<void> onRegisterScreenDisablityDropDownEvent(
      RegisterScreenDisablityDropDownEvent event,
      Emitter<RegisterScreenState> emit) async {
    selectedDisablityType = event.selectedValue;
    emit(RegisterScreenLoadingCompletedState());
    return;
  }

  Future<void> onRegisterScreenDisablityStatusDropDownEvent(
      RegisterScreenDisablityStatusDropDownEvent event,
      Emitter<RegisterScreenState> emit) async {
    isChildDisablity = event.selectedValue;
    emit(RegisterScreenLoadingCompletedState());
    return;
  }

  Future<void> onRegisterScreenRegisterButtonClickEvent(
    RegisterScreenRegisterButtonClickEvent event,
    Emitter<RegisterScreenState> emit,
  ) async {
    // emit(NavigateToHomeScreenState());
    ValidationState state;
    state = Validator.validate(nameTextController.text, rules: ['required']);
    if (!state.status) {
      emit(
        RegisterScreenErrorState(
          '${state.error}',
        ),
      );
      return;
    }

    emit(RegisterScreenLoadingState());
    final response = await registerUseCase.call(
        params: RegisterParams(
            name: nameTextController.text,
            className: selectedClassName!,
            disablityType:  selectedDisablityType != null ? selectedDisablityType : null));

    response.fold(
        (l) => {emit(RegisterScreenErrorState(l.toString()))},
        (r) => {
              loginResponseModel?.student = r.student,
              appPreferences.setUser(loginResponseModel!),
              emit(RegisterScreenSuccessState(message: r.msg))
            });
  }
}
