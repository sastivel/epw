import 'package:EPW_mobile/custome_widgets/custom_style.dart';
import 'package:EPW_mobile/screens/home/bloc/home_bloc.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../bloc/home_event.dart';

class MyHomeScreenWidgets {
static Widget cardWithImage(BuildContext context,bool isLeft,String imageResorce,String text){
   return   Container(
                  margin: EdgeInsets.only( left: isLeft ? 5 : 0),
                 child:  Card(
                     shape: RoundedRectangleBorder(
    side: const BorderSide(color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
                   child: Container(
                    padding: EdgeInsets.all(16),
                    height: 160,width: 160,
                    child: Column(
                      children: [
                        Image.asset(imageResorce,height: 90,width: 90,),
                        SizedBox(height: 10,),
                        Expanded(child: Text(text.tr(context: context),style: CustomStyle.size18w400CAPPTXTCOLOR(),))
                      ],
                    )),
                 ),
               );
}

static Widget languageSwitch(HomeScreenBloc bloc,BuildContext context){
 return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
               Text(StringResource.ENGLISH,style: CustomStyle.size14w400CAPPCOLOR(),),
              const SizedBox(width: 10),
                    Switch(value:bloc.languageValue ?? false,activeColor: ColorResource.COLOR_APP_TEXT_FIELD_BORDER, onChanged: (bool)=>{
              
               if(bool == true){
  EasyLocalization.of(context)!.setLocale(context.supportedLocales[1]),
               }else{
  EasyLocalization.of(context)!.setLocale(context.supportedLocales[0]),
               },
             
               bloc!.add(HomeScreenLanguageChangeEvent(bool)),
              
              }),
              const   SizedBox(width: 10),
              Text(StringResource.TAMIL,style: CustomStyle.size14w400CAPPCOLOR(),),
    ],);
}
}