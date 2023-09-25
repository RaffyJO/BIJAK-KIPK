import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hyper_ui/core.dart';

class LoginFormController extends State<LoginFormView> {
  static late LoginFormController instance;
  late LoginFormView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String email = "";
  String password = "";

  DoEmailLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FloatMainNavigationView(
                  initialSelectedIndex: 0,
                )),
      );
    } on Exception catch (_) {
      print(_);
      showInfoDialog("Email atau password anda salah!");
    }
  }

  DoGoogleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      await googleSignIn.disconnect();
    } catch (_) {}

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("userCredential: $userCredential");

      print("Login berhasil");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FloatMainNavigationView(
                  initialSelectedIndex: 0,
                )),
      );
    } catch (_) {
      print(_);
    }
  }
}
