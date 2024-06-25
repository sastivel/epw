import 'common_imports.dart';

class DecorationUtils {
  static BoxDecoration infoCardDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 241, 245, 245),
      border: Border.all(
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 30,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
