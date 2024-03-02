import 'package:pakwanderer/Packages/packages.dart';

showProfileOptions(BuildContext context) {
  List<String> tileTitles = ['Favorites', 'Reservations', 'Logout'];

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        ),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < tileTitles.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(i.toString());
                      i == 0
                          ? screenFunctions.nextScreen(
                              context, const FavoriteScreen())
                          : i == 1 && firebaseAuth.currentUser != null
                              ? screenFunctions.nextScreen(
                                  context, const ReservationScreen())
                              : i == 1 && firebaseAuth.currentUser == null
                                  ? goToLogin(context)
                                  : i == 2 && firebaseAuth.currentUser != null
                                      ? signOut(context)
                                      : null;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Text(
                        tileTitles[i],
                        style: roboto20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

goToLogin(context) async {
  await screenFunctions.popScreen(context);
  screenFunctions.nextScreen(context, const LoginScreen());
}

signOut(context) async {
  await FirebaseAuth.instance.signOut();
  showMessage(context, Colors.green, 'Logged Out!!!!');
  screenFunctions.popScreen(context);
}
