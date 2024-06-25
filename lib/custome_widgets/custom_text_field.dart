import '../utils/color_resource.dart';
import '../utils/common_imports.dart';

class CustomTextField extends StatefulWidget {
  String hint;
  TextEditingController textController;
  FocusNode? currentNode;
  FocusNode? nextNode;
  bool isObscure;
  bool? isMandatory;
  int maxLines;
  double height;
  int? maxLength;
  Function? onChange;
  bool isReadOnly;
  TextInputType inputType;
  String? suffixIconUrl;
  TextStyle? hintStyle;
  TextAlignVertical? textAlignVertical;
  Icon? prefixIcon;
  Function? onTap;
  TextStyle? style;

  CustomTextField(
      {required this.hint,
      required this.textController,
      this.isMandatory = false,
      this.hintStyle,
      this.currentNode,
      this.suffixIconUrl,
      this.nextNode,
      this.isObscure = false,
      this.maxLines = 1,
      this.height = 67,
      this.maxLength,
      this.onChange,
      this.isReadOnly = false,
      this.textAlignVertical,
      this.prefixIcon,
      this.inputType = TextInputType.text,
      this.style,
      this.onTap});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: widget.style,
              textAlignVertical: widget.textAlignVertical,
              maxLength: widget.maxLength,
              controller: widget.textController,
              focusNode: widget.currentNode,
              obscureText: widget.isObscure,
              maxLines: widget.maxLines,
              readOnly: widget.isReadOnly,
              keyboardType: widget.inputType,
              inputFormatters: widget.inputType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              onChanged: (vale) {
                if (widget.onChange != null) {
                  widget.onChange!();
                }
              },
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.white, filled: true,
                prefixIcon: widget.prefixIcon,
                label: widget.isMandatory!
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.hint,
                            //  style: CustomStyle.size14w500C000000(),
                          ),
                          const Text(
                            '*',
                            //  style: CustomStyle.size16w400CFF0000(context),
                          )
                        ],
                      )
                    : null,
                //labelText: widget.hint,
                // labelStyle: CustomStyle.size14w500C000000(),
                focusColor: ColorResource.Color_C2C2C2,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: ColorResource.COLOR_APP_TEXT_FIELD_BORDER),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(color: ColorResource.Color_C2C2C2),
                ),
                contentPadding: widget.maxLines == 1
                    ? const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 2,
                        bottom: 2,
                      )
                    : const EdgeInsets.only(left: 20, top: 30, right: 10),
                hintText: widget.isMandatory! ? null : widget.hint,
                hintStyle: widget.hintStyle,
                suffixIcon: widget.suffixIconUrl != null
                    ? Image.asset(widget.suffixIconUrl!)
                    : null,
              ),
              onSubmitted: (value) {
                if (widget.nextNode != null) {
                  FocusScope.of(context).requestFocus(widget.nextNode);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
