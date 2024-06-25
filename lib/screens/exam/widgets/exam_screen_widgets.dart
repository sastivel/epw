import 'package:EPW_mobile/screens/exam/bloc/exam_bloc.dart';

import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../../profile/bloc/profile_bloc.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/exam_event.dart';

class ExamWidgets {
  static Widget StartExamBtn(BuildContext context, ExamScreenBloc bloc) {
    return InkWell(
      onTap: () {
        bloc.add(ExamScreenExamButtonClickEvent());
      },
      child: Container(
          alignment: FractionalOffset.center,
          height: 40,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResource.COLOR_APP_BTN),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Text(
            StringResource.STARTQUIZ.tr(),
            style: CustomStyle.size14w500white(),
          )),
    );
  }
}
