// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../core.dart';

class SignUpFormView extends StatefulWidget {
  const SignUpFormView({Key? key}) : super(key: key);

  Widget build(context, SignUpFormController controller) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF9B51E0),
          title: const Text("SignUp Form"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 40),
          height: 400,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              QTextField(
                label: "Email",
                helper: "Masukkan Email Anda",
                validator: Validator.required,
                suffixIcon: Icons.email,
                onChanged: (value) {
                  controller.email = (value);
                },
              ),
              SizedBox(
                height: 15,
              ),
              QTextField(
                label: "Password",
                helper: "Masukkan Password Anda",
                validator: Validator.required,
                hint: "password berisi minimal 6 karakter",
                suffixIcon: Icons.lock,
                onChanged: (value) {
                  controller.password = (value);
                },
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9B51E0),
                ),
                onPressed: () {
                  controller.DoSignUp();
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ));
  }

  @override
  State<SignUpFormView> createState() => SignUpFormController();
}
