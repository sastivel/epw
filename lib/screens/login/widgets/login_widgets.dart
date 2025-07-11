
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../custome_widgets/custom_style.dart';
import '../../../custome_widgets/custom_text_field.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';

class MyLoginWidgets {
static Widget mobileNumberTextBox(BuildContext context,LoginScreenBloc bloc,String type){
   return    Container(
                   
                    height: 64,
                    margin:  EdgeInsets.only(right: 30,left: 30),
                    child: CustomTextField(
                        hint: StringResource.ENTERPHNNUM.tr(context: context),
                          inputType:TextInputType.number,
                        textController: bloc.mobileNumberController),
                  );
}

 static Widget loginbtn(BuildContext context,LoginScreenBloc bloc,String type) {
    return InkWell(
      onTap: () {
        bloc.add(LoginScreenLoginButtonClickEvent());
     
      },
      child:
       Container(
          alignment: FractionalOffset.center,
          height: 40,
          width:150,
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
