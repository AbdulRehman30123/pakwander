import 'package:pakwanderer/Packages/packages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splashImage.png'),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.15, horizontal: width * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Travel Pakistan',
                textScaleFactor: ScaleSize.textScaleFactor(context),
                style: openSans,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Lets Explore\nThe beauty of\nPakistan',
                textScaleFactor: ScaleSize.textScaleFactor(context),
                style: roboto40,
                textAlign: TextAlign.left,
              ),
              Text(
                'Welcome to Heaven on Earth',
                textScaleFactor: ScaleSize.textScaleFactor(context),
                style: roboto20,
              ),
              SizedBox(
                height: height * 0.2,
              ),
              GestureDetector(
                onTap: () {
                  screenFunctions.nextScreen(
                    context,
                    const HomeScreen(),
                  );
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.yellow, width: 2.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Explore Now',
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      style: roboto20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
