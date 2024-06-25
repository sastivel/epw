// ignore: must_be_immutable
import '../utils/color_resource.dart';
import '../utils/common_imports.dart';

class CustomPasswordField extends StatefulWidget {
  String hint;
  TextEditingController textController;
  FocusNode? currentNode;
  FocusNode? nextNode;
  bool isObscure;
  Widget suffixIcon;
  TextStyle? hintStyle;
  bool? isMandatory;

  CustomPasswordField({super.key, 
    required this.textController,
    required this.hint,
    this.currentNode,
    this.nextNode,
    this.isObscure = false,
    required this.suffixIcon,
    this.hintStyle,
    this.isMandatory = false,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.textController,
              focusNode: widget.currentNode,
              obscureText: !widget.isObscure,
              decoration: InputDecoration(
                  label: widget.isMandatory!
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.hint,
                              //  style: CustomStyle.size16w400CA7A7A7(context),
                            ),
                            const Text(
                              '*',
                              //  style: CustomStyle.size16w400CFF0000(context),
                            )
                          ],
                        )
                      : null,
                  //labelText: widget.hint,
                  //   labelStyle: CustomStyle.size16w400CA7A7A7(context),
                  focusColor: ColorResource.Color_C2C2C2,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: ColorResource.Color_C2C2C2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: ColorResource.Color_C2C2C2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: ColorResource.Color_C2C2C2),
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    bottom: 2,
                    top: 2,
                    right: 20,
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: widget.suffixIcon,
                  ),
                  hintText: widget.isMandatory! ? null : widget.hint,
                  hintStyle: widget.hintStyle),
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
