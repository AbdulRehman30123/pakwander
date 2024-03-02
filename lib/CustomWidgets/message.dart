import 'package:pakwanderer/Packages/packages.dart';

showMessage(BuildContext context, Color snackBarColor, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: snackBarColor,
      content: Text(message),
    ),
  );
}
