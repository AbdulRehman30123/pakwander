// ignore_for_file: use_build_context_synchronously

import 'package:pakwanderer/Packages/packages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obsecure = false;
  bool isSignUp = false;
  signUpFunction(emailController, passwordController, numberController,
      nameController, BuildContext context) async {
    setState(() {
      isSignUp = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': nameController,
        'email': emailController,
        'number': numberController,
        'password': passwordController,
      });
      setState(() {
        isSignUp = false;
      });
      screenFunctions.popScreen(context);
      screenFunctions.popScreen(context);
      showMessage(context, secondaryColor, 'Account created successfully!!');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isSignUp = false;
      });
      if (e.code == 'weak-password') {
        showMessage(context, Colors.red, 'Password is too weak!!');
      } else if (e.code == 'email-already-in-use') {
        showMessage(context, Colors.red, 'Email already exist!!');
      }
    } catch (e) {
      setState(() {
        isSignUp = false;
      });
      print(e);
    }
  }

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    numberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                height: height * .7,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        normalTextField(nameController, 'Name'),
                        normalTextField(emailController, 'Email'),
                        normalTextField(numberController, 'Phone Number'),
                        passwordTextField(
                            passwordController, 'Password', obsecure, () {
                          setState(() {
                            obsecure = !obsecure;
                          });
                        }),
                        roundedButton(() {
                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty &&
                              nameController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            showMessage(context, Colors.red,
                                'Please enter in all fields!!');
                          } else if (emailController.text.isEmpty) {
                            showMessage(context, Colors.red,
                                'Please enter your email!!');
                          } else if (passwordController.text.isEmpty) {
                            showMessage(context, Colors.red,
                                'Please enter your password!!');
                          } else if (nameController.text.isEmpty) {
                            showMessage(context, Colors.red,
                                'Please enter your Name!!');
                          } else if (numberController.text.isEmpty) {
                            showMessage(context, Colors.red,
                                'Please enter your Number!!');
                          } else {
                            signUpFunction(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                numberController.text.trim(),
                                nameController.text.trim(),
                                context);
                          }
                        }, 'SignUp'),
                        GestureDetector(
                          onTap: () {
                            screenFunctions.popScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: const TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Login',
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
          if (isSignUp)
            Container(
              color: secondaryColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
