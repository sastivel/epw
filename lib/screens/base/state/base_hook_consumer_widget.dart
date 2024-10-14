// Remember to inherit from HookWidget

import '../../../core/router/app_routes.dart';
import '../../../utils/common_imports.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

abstract class BaseHookWidget extends HookWidget {
  const BaseHookWidget({super.key});
    
    Widget build(BuildContext context) {
      return Container();
    }
  
  showToast({required BuildContext context, required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  moveToHome(BuildContext context) {}

  horizontalDivider({double? height = 2, Color? color = Colors.grey}) {
    return Container(
      height: height!,
      decoration: BoxDecoration(color: color!),
    );
  }

  space5() {
    return const SizedBox(
      height: 5,
    );
  }

  space10() {
    return const SizedBox(
      height: 10,
    );
  }

  space15() {
    return const SizedBox(
      height: 15,
    );
  }

  space20() {
    return const SizedBox(
      height: 20,
    );
  }

  space20w() {
    return const SizedBox(
      width: 20,
    );
  }

  space50w() {
    return const SizedBox(
      width: 50,
    );
  }

  pushNamed(BuildContext context, BaseHookWidget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  pushReplacement(BuildContext context, BaseHookWidget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  spacegreyh1() {
    return Container(
      height: 1,
      color: Color.fromARGB(255, 236, 235, 235),
    );
  }
}
