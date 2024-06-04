import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/pages/home/admin_screen.dart';
import 'package:flutter_application_1/pages/home/signup_screen.dart';
import 'package:flutter_application_1/pages/utils/components/background.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../config/constants.dart';
import '../utils/components/already_have_an_account_acheck.dart';
import '../utils/components/rounded_button.dart';
import '../utils/components/rounded_input_field.dart';
import '../utils/components/rounded_login_button.dart';
import '../utils/components/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const idScreen = "login";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "ЛОГИН",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Brand Bold"),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "lib/assets/icons/signup.png",
                  height: size.height * 0.35,
                  //color: Constants.kPrimaryLightColor,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  hintText: "Email",
                  hintStyle: const TextStyle(fontFamily: "Brand-Regular"),
                  onChanged: (value) {
                    email = value;
                    emailController.text = email;
                  },
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{4,}$');
                    if (value.isEmpty) {
                      return ("Pin is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Pin(Min. 4 Character)");
                    }
                    return null;
                  },
                  hintText: "Password",
                  hintStyle: const TextStyle(fontFamily: "Brand Bold"),
                  onChanged: (value) {
                    password = value;
                    passwordController.text = password;
                  },
                ),
                RoundedLoginButton(
                  text: "ВОЙТИ",
                  press: () {
                    signIn(emailController.text, passwordController.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "user") {
          toastBar("success");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else if (documentSnapshot.get('role') == "Admin") {
          toastBar("success");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminScreen(),
            ),
          );
        } else {
          toastBar("success");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      } else {
        print('This user is not a ' + documentSnapshot.get('role'));
      }
    });
  }

  void toastBar(String message) {
    if (message == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFF36827F),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 48,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Success!",
                            style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ubuntu",),
                          ),
                          Spacer(),
                          Text(
                            "Авторизация успешна",
                            style: TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "ubuntu"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset("lib/assets/icons/bubbles.svg",
                    height: 48,
                    width: 40,
                    color: const Color(0xFF295147),
                  ),
                ),
              ),
              Positioned(
                top: -20,
                left: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/icons/success.png",
                      height: 40,
                    ),
                    Positioned(
                      top: 10,
                      child: SvgPicture.asset(
                        "lib/assets/icons/close.svg",
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }

  void signIn(String email, String password) async {
    try {
      if (email == 'admin@gmail.com' && password == 'admin1234') {
        // Directly navigate to AdminScreen if the credentials match
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminScreen())
        );
        return;
      }

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        //Fluttertoast.showToast(msg: "Login Successful"),
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFF36827F),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 48,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Success!",
                              style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ubuntu",),
                            ),
                            Spacer(),
                            Text(
                              "Авторизация успешна",
                              style: TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "ubuntu"),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    child: SvgPicture.asset("lib/assets/icons/bubbles.svg",
                      height: 48,
                      width: 40,
                      color: const Color(0xFF295147),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "lib/assets/icons/success.png",
                        height: 40,
                      ),
                      Positioned(
                        top: 10,
                        child: SvgPicture.asset(
                          "lib/assets/icons/close.svg",
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage())),
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFFC72C41),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 48,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Oh snap!!",
                            style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ubuntu",),
                          ),
                          const Spacer(),
                          Text(
                            errorMessage!,
                            style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "ubuntu"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset("lib/assets/icons/bubbles.svg",
                    height: 48,
                    width: 40,
                    color: const Color(0xFF801336),
                  ),
                ),
              ),
              Positioned(
                top: -20,
                left: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      "lib/assets/icons/fail.svg",
                      height: 40,
                    ),
                    Positioned(
                      top: 10,
                      child: SvgPicture.asset(
                        "lib/assets/icons/close.svg",
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      print(error.code);
    }
  }
}
