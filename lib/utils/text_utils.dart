import '../custome_widgets/custom_style.dart';
import 'common_imports.dart';

class HeaderText {
  static Widget build({required String headerText, bool isMandatory = false}) {
    return Row(
      children: [
        Text(
          headerText,
          style: CustomStyle.size16w600C000000(),
        ),
        isMandatory
            ? Text(
                '*',
                style: CustomStyle.buildRequiredField(),
              )
            : Container(),
      ],
    );
  }
}

class SubHeaderText {
  static Widget build({required String headerText, bool isMandatory = false}) {
    return Row(
      children: [
        Text(
          headerText,
          style: CustomStyle.size14w600C000000(),
        ),
        isMandatory
            ? Text(
                '*',
                style: CustomStyle.buildRequiredField(),
              )
            : Container(),
      ],
    );
  }
}

class CustomTextFormField {
  static Widget build({
    required TextEditingController controller,
    required String label,
    bool isMandatory = false,
    Function? validator,
  }) {
    return Container(
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                label,
                style: CustomStyle.size14w500grey(),
              ),
              isMandatory
                  ? Text(
                      '*',
                      style: CustomStyle.buildRequiredField(),
                    )
                  : Container(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 100,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: (value) {
                if (validator != null) {
                  validator(value);
                }
              },
              decoration: InputDecoration(
                hintText: label,
                hintStyle: CustomStyle.size12w500grey(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.0),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.0),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormFieldDecor {
  static InputDecoration build({
    required String label,
  }) {
    return InputDecoration(
      counterText: '',
      hintText: label,
      hintStyle: CustomStyle.size12w500grey(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}

class TextFormFieldDecorWithSuffix {
  static InputDecoration build(
      {required String label, required Widget suffix}) {
    return InputDecoration(
      suffixIcon: suffix,
      hintText: label,
      hintStyle: CustomStyle.size12w500grey(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}

class DisabilityConversion {
  static String disAbilityConvertToEnglish(type) {
    return type == "பார்வை கோளாறு"
        ? "Visual Impairment"
        : type == "செவித்திறன் குறைபாடு"
            ? "Hearing Impairment"
            : "Mild Intellectual Disability";
  }

  disAbilityConvertToLocale(context, type) {
    //  "VisualImpairment": "Visual Impairment",
    // "HearingImpairment": "Hearing Impairment",
    // "MildIntellectualDisability": "Mild Intellectual Disability"
    //  "VisualImpairment": "பார்வை கோளாறு",
    // "HearingImpairment": "செவித்திறன் குறைபாடு",
    // "MildIntellectualDisability": "லேசான அறிவுசார் குறைபாடு"
    if (context.locale.toString() == "ta_IN") {}
  }
}
