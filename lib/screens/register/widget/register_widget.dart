import 'package:EPW_mobile/screens/profile/bloc/profile_bloc.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../custome_widgets/custom_style.dart';
import '../../../custome_widgets/custom_text_field.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';

class RegisterScreenWidgets {
  static Widget nameTxtBox(BuildContext context, RegisterScreenBloc bloc) {
    return Container(
      // margin: const EdgeInsets.only(right: 20,left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringResource.NAME.tr(),
            style: CustomStyle.size14w400CAPPTXTCOLOR(),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 30,
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: CustomTextField(
                hint: StringResource.ENTRSTUDNAME.tr(),
                inputType: TextInputType.text,
                textController: bloc.nameTextController),
          ),
        ],
      ),
    );
  }

  static Widget classDropDown(BuildContext context, RegisterScreenBloc bloc) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringResource.CLASS.tr(),
            style: CustomStyle.size14w400CAPPTXTCOLOR(),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(
                  color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            margin: EdgeInsets.only(right: 20),
            child: DropdownButton<String>(
              value: bloc.selectedClassName,
              underline: const SizedBox(),
              iconSize: 0,
              borderRadius: BorderRadius.circular(8),
              items: <String>['6', '7', '8', '9'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                bloc.add(RegisterScreenDropDownEvent(value));
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget disablityDropDown(
      BuildContext context, RegisterScreenBloc bloc) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringResource.DISBLITYTYPE.tr(),
            style: CustomStyle.size14w400CAPPTXTCOLOR(),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(
                  color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            margin: EdgeInsets.only(right: 20),
            child: DropdownButton<String>(
              value: bloc.selectedDisablityType,
              underline: const SizedBox(),
              iconSize: 0,
              borderRadius: BorderRadius.circular(8),
              items: <String>[
                "Visual Impairment",
                "Hearing Impairment",
                "Mild Intellectual Disability",
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                bloc.add(RegisterScreenDisablityDropDownEvent(value));
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget disablityStatusDropDown(
      BuildContext context, RegisterScreenBloc bloc) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringResource.DISBLITYTYPETRUEORFALSE.tr(),
            style: CustomStyle.size14w400CAPPTXTCOLOR(),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(
                  color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER,
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            margin: EdgeInsets.only(right: 20),
            child: DropdownButton<String>(
              value: bloc.isChildDisablity,
              underline: const SizedBox(),
              iconSize: 0,
              borderRadius: BorderRadius.circular(8),
              items: <String>["Yes", "No"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                bloc.add(RegisterScreenDisablityStatusDropDownEvent(value));
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget registerbtn(BuildContext context, RegisterScreenBloc bloc) {
    return InkWell(
      onTap: () {
        bloc!.add(RegisterScreenRegisterButtonClickEvent());
        // Navigator.pushNamed(context, AppRoutes.homeScreen);
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.SUBMIT.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }
}
