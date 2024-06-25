import 'package:flutter/material.dart';
import '../utils/color_resource.dart';
import '../utils/fonts.dart';
import 'custom_text.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final double height,
      width,
      radius,
      marginAll,
      marginLeft,
      marginRight,
      marginBottom,
      marginTop,
      paddingAll;

  final Color color;
  CustomButton(this.text,
      {this.onTap,
      this.color = ColorResource.BLACK000000,
      this.height = 56.0,
      this.width = 0.0,
      this.radius = 8.0,
      this.marginAll = 0.0,
      this.marginBottom = 0.0,
      this.marginTop = 0.0,
      this.marginLeft = 0.0,
      this.paddingAll = 0.0,
      this.marginRight = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: marginAll != 0.0
            ? EdgeInsets.all(marginAll)
            : EdgeInsets.only(
                top: marginTop,
                bottom: marginBottom,
                left: marginLeft,
                right: marginRight),
        padding: paddingAll != 0.0
            ? EdgeInsets.all(paddingAll)
            : EdgeInsets.all(paddingAll),
        alignment: AlignmentDirectional.center,
        height: height,
        width: width == 0.0 ? MediaQuery.of(context).size.width : width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            )),
        child: InkWell(
          onTap: () {
            _onButtonClickAction();
          },
          child: Center(
            child: CustomText(
              text,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              font: Font.urbanistMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  _onButtonClickAction() {
    if (onTap != null) onTap!();
  }
}