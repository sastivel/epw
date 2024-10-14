import 'package:EPW_mobile/api/interface/base/base_response.dart';
import 'package:EPW_mobile/api/interface/login/login_response.dart';
import 'package:EPW_mobile/screens/profile/bloc/profile_event.dart';
import 'package:EPW_mobile/screens/profile/bloc/profile_state.dart';

import '../../../core/preference/app_preference.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/validator.dart';
import '../usecase/profile_usecase.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final ProfileUseCase profileUseCase;
  final AppPreferences appPreferences;
  TextEditingController nameTextController = TextEditingController();

  BaseResponse? baseResponse;
  late BuildContext context;
  String? selectedClassName;
  String? selectedDisablityType;
  String? isChildDisablity;
  LoginResponseModel? loginResponseModel;
  ProfileScreenBloc(
      {required this.profileUseCase, required this.appPreferences})
      : super(ProfileScreenInitaialState()) {
    on<ProfileScreenInitialEvent>(onProfileScreenInitialEvent);
    on<ProfileScreenDropDownEvent>(onProfileScreenDropDownEvent);
    on<ProfileScreenDisablityDropDownEvent>(
        onProfileScreenDisablityDropDownEvent);
    on<ProfileScreenProfileButtonClickEvent>(
        onProfileScreenProfileButtonClickEvent);
    on<ProfileScreenDisablityStatusDropDownEvent>(
        onProfileScreenDisablityStatusDropDownEvent);
    add(ProfileScreenInitialEvent());
  }

  Future<void> onProfileScreenInitialEvent(
    ProfileScreenInitialEvent event,
    Emitter<ProfileScreenState> emit,
  ) async {
    emit(ProfileScreenLoadingState());
    print('****************coming****************');
    //  AppUtils.isLoggedIn = false;
    loginResponseModel = await appPreferences.getUser();
    print(
        '***************print************${loginResponseModel?.user?.toJson()}');

    if (loginResponseModel?.student != null &&
        loginResponseModel?.student?.className != null) {
      selectedClassName = loginResponseModel?.student?.className;
      selectedDisablityType = loginResponseModel?.student?.disablityType;
      if (selectedDisablityType == null || selectedDisablityType == '') {
        isChildDisablity = "No";
      } else {
        isChildDisablity = "Yes";
      }
      //  selectedDisablityType =
    }
    if (loginResponseModel?.student != null &&
        loginResponseModel?.student?.name != null) {
      nameTextController.text = loginResponseModel!.student!.name!;
    }

    emit(ProfileScreenLoadingCompletedState());
  }

  Future<void> onProfileScreenDropDownEvent(ProfileScreenDropDownEvent event,
      Emitter<ProfileScreenState> emit) async {
    selectedClassName = event.selectedValue;
    emit(ProfileScreenLoadingCompletedState());
    return;
  }

  Future<void> onProfileScreenDisablityDropDownEvent(
      ProfileScreenDisablityDropDownEvent event,
      Emitter<ProfileScreenState> emit) async {
    selectedDisablityType = event.selectedValue;
    emit(ProfileScreenLoadingCompletedState());
    return;
  }

  Future<void> onProfileScreenDisablityStatusDropDownEvent(
      ProfileScreenDisablityStatusDropDownEvent event,
      Emitter<ProfileScreenState> emit) async {
    isChildDisablity = event.selectedValue != null && event.selectedValue != '' ? "Yes" : "No"  ;
    selectedDisablityType = "Visual Impairment";
    emit(ProfileScreenLoadingCompletedState());
    return;
  }

  Future<void> onProfileScreenProfileButtonClickEvent(
    ProfileScreenProfileButtonClickEvent event,
    Emitter<ProfileScreenState> emit,
  ) async {
    // emit(NavigateToHomeScreenState());
    ValidationState state;
    state = Validator.validate(nameTextController.text, rules: ['required']);
    if (!state.status) {
      emit(
        ProfileScreenErrorState(
          '${state.error}',
        ),
      );
      return;
    }

    emit(ProfileScreenLoadingState());
    final response = await profileUseCase.call(
        params: ProfileParams(
            id: loginResponseModel?.student?.id,
            name: nameTextController.text,
            className: selectedClassName!,
            disablityType: selectedDisablityType ?? null));

    response.fold(
        (l) => {emit(ProfileScreenErrorState(l.toString()))},
        (r) => {
              loginResponseModel?.student = r.student,
            //  appPreferences.clearStorage(),
              appPreferences.setUser(loginResponseModel!),
              emit(ProfileScreenSuccessState(message: r.msg))
            });
  }
}
