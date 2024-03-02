import 'package:pakwanderer/Packages/packages.dart';

void showExitPopup(
  BuildContext context,
  Function()? noTap,
  Function()? yesTap,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: 350,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Are you sure you want to exit?',
                    style: GoogleFonts.lato(
                        color: const Color(0xff303030),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: noTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff1A2659).withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                          height: 48,
                          width: 110,
                          child: Text(
                            'No',
                            style: GoogleFonts.lato(
                                color: const Color(0xff303030),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: yesTap,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: secondaryColor,
                        ),
                        alignment: Alignment.center,
                        height: 48,
                        width: 110,
                        child: Text(
                          'Yes',
                          style: GoogleFonts.lato(
                              color: const Color(0xffFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
    },
  );
}
