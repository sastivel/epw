import 'package:EPW_mobile/custome_widgets/custom_style.dart';
import 'package:EPW_mobile/screens/login/bloc/login_bloc.dart';
import 'package:EPW_mobile/utils/string_resource.dart';
import 'package:easy_localization/easy_localization.dart';

import '../screens/login/bloc/login_event.dart';
import '../utils/color_resource.dart';
import '../utils/common_imports.dart';

class CustomTranslationWidget extends StatelessWidget {
  LoginScreenBloc? bloc;
   CustomTranslationWidget({this.bloc});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
               Text(StringResource.ENGLISH,style: CustomStyle.size14w400CAPPCOLOR(),),
              const SizedBox(width: 10),
               Switch(value:bloc!.languageValue ?? false,activeColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER, onChanged: (bool)=>{
              
               if(bool == true){
  EasyLocalization.of(context)!.setLocale(context.supportedLocales[1]),
               }else{
  EasyLocalization.of(context)!.setLocale(context.supportedLocales[0]),
               },
             
               bloc!.add(LoginScreenLanguageChangeEvent(bool)),
              
              }),
              const   SizedBox(width: 10),
              Text(StringResource.TAMIL,style: CustomStyle.size14w400CAPPCOLOR(),),
    ],);
  }
}