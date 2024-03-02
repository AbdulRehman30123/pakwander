import 'package:pakwanderer/Auth/signup_screen.dart';
import 'package:pakwanderer/Packages/packages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecure = false;
  bool loginStart = false;
  loginFunction(emailController, passwordController) async {
    setState(() {
      loginStart = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      setState(() {
        loginStart = false;
      });
      screenFunctions.popScreen(context);
      showMessage(context, Colors.green, 'Login Successfully');
    } on FirebaseAuthException catch (e) {
      setState(() {
        loginStart = false;
      });
      if (e.code == 'user-not-found') {
        showMessage(context, Colors.red, 'No User Found!!');
      } else if (e.code == 'wrong-password') {
        showMessage(context, Colors.red, 'Password is worong!!');
      }
    }
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splashImage.png'),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: height * .6,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    normalTextField(emailController, 'Email'),
                    passwordTextField(passwordController, 'Password', obsecure,
                        () {
                      setState(() {
                        obsecure = !obsecure;
                      });
                    }),
                    roundedButton(() {
                      if (emailController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        showMessage(context, Colors.red,
                            'Please enter in all fields!!');
                      } else if (emailController.text.isEmpty) {
                        showMessage(
                            context, Colors.red, 'Please enter your email!!');
                      } else if (passwordController.text.isEmpty) {
                        showMessage(context, Colors.red,
                            'Please enter your password!!');
                      } else {
                        loginFunction(emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    }, loginStart ? 'Logging..' : 'Login'),
                    GestureDetector(
                      onTap: () {
                        screenFunctions.nextScreen(
                          context,
                          const SignUpScreen(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
