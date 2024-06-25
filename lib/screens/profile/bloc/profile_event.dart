import '../../../api/base_equatable.dart';

class ProfileScreenEvent extends BaseEquatable {}

class ProfileScreenInitialEvent extends ProfileScreenEvent {}

class ProfileScreenProfileButtonClickEvent extends ProfileScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class ProfileScreenSuccessEvent extends ProfileScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class ProfilePasswordVisibilityChangedEvent extends ProfileScreenEvent {
  @override
  bool operator ==(Object other) => false;
}

class ProfileScreenErrorEvent extends ProfileScreenEvent {
  final String? error;
  ProfileScreenErrorEvent(this.error);
}

class ProfileScreenDropDownEvent extends ProfileScreenEvent {
  final String? selectedValue;
  ProfileScreenDropDownEvent(this.selectedValue);
}

class ProfileScreenDisablityDropDownEvent extends ProfileScreenEvent {
  final String? selectedValue;
  ProfileScreenDisablityDropDownEvent(this.selectedValue);
}

class ProfileScreenDisablityStatusDropDownEvent extends ProfileScreenEvent {
  final String? selectedValue;
  ProfileScreenDisablityStatusDropDownEvent(this.selectedValue);
}
