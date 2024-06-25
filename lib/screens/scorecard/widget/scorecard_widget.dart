import 'package:EPW_mobile/screens/exam/bloc/exam_bloc.dart';

import '../../../custome_widgets/custom_style.dart';
import '../../../utils/color_resource.dart';
import '../../../utils/common_imports.dart';
import '../../../utils/string_resource.dart';
import '../../profile/bloc/profile_bloc.dart';
import 'package:EPW_mobile/utils/color_resource.dart';
import 'package:easy_localization/easy_localization.dart';


class ScoreCardWidgets {
  static Widget homeBtn(BuildContext context) {
    return Container(
        alignment: FractionalOffset.center,
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResource.COLOR_APP_BTN),
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Text(
          StringResource.HOME.tr(),
          style: CustomStyle.size14w500white(),
        ));
  }
}
