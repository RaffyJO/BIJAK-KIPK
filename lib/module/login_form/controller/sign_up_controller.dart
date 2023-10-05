import 'dart:async';

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
  bool isEmailVerified = false;

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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      await user?.sendEmailVerification();

      // Tampilkan popup loading
      showDialog(
        context: context,
        barrierDismissible:
            false, // Tidak bisa menutup popup dengan klik di luar
        builder: (context) => AlertDialog(
          title: Text("Verifikasi Email"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Sedang menunggu verifikasi email..."),
            ],
          ),
        ),
      );

      Timer.periodic(Duration(seconds: 5), (timer) async {
        await user?.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user?.emailVerified == true) {
          Navigator.of(context).pop();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataDiriView()),
          );

          timer.cancel();
        }
      });
    } catch (error) {
      print(error);
      showInfoDialog("Email sudah pernah dibuat");
    }
  }
}
