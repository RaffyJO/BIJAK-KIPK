import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class SignUpFormController extends State<SignUpFormView> {
  static late SignUpFormController instance;
  late SignUpFormView view;

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

  DoSignUp() async {
    if (password.length < 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Gagal SignUp"),
          content: Text("Password harus terdiri dari minimal 6 karakter"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataDiriView()),
      );
    } on Exception catch (_) {
      print(_);
      showInfoDialog("Email dan password sudah pernah dibuat");
    }
  }
}
