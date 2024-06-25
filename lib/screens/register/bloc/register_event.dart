import '../../../api/base_equatable.dart';

class RegisterScreenEvent extends BaseEquatable {}

class RegisterScreenInitialEvent extends RegisterScreenEvent {}

class RegisterScreenRegisterButtonClickEvent extends RegisterScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class RegisterScreenSuccessEvent extends RegisterScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class RegisterPasswordVisibilityChangedEvent extends RegisterScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class RegisterScreenErrorEvent extends RegisterScreenEvent {
  final String? error;
  RegisterScreenErrorEvent(this.error);
}

class RegisterScreenDropDownEvent extends RegisterScreenEvent {
  final String? selectedValue;
  RegisterScreenDropDownEvent(this.selectedValue);
}

class RegisterScreenDisablityDropDownEvent extends RegisterScreenEvent {
  final String? selectedValue;
  RegisterScreenDisablityDropDownEvent(this.selectedValue);
}

class RegisterScreenDisablityStatusDropDownEvent extends RegisterScreenEvent {
  final String? selectedValue;
  RegisterScreenDisablityStatusDropDownEvent(this.selectedValue);
}
