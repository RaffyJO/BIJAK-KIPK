import 'package:flutter/material.dart';

import '../../../core.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({Key? key}) : super(key: key);

  Widget build(context, LoginFormController controller) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF9B51E0),
          title: const Text("LogIn Form"),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Container(
                height: 250,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/aset/logo.png",
                    // width: 180,
                    // height: 180,
                    // fit: BoxFit.fill
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    QTextField(
                      label: "Email",
                      validator: Validator.email,
                      suffixIcon: Icons.email,
                      helper: "Masukkan Email Anda",
                      onChanged: (value) {
                        controller.email = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    QTextField(
                      label: "Password",
                      helper: "Masukkan Password Anda",
                      obscure: true,
                      validator: Validator.required,
                      suffixIcon: Icons.remove_red_eye_outlined,
                      isObscured: false,
                      onChanged: (value) {
                        controller.password = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 170,
                      height: 50,
                      child: QButton(
                          label: "LogIn",
                          color: Color(0xFF9B51E0),
                          onPressed: () => controller.DoEmailLogin()),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      width: 170,
                      height: 50,
                      child: QButton(
                          label: "LogIn with Google",
                          color: Color(0xFF9B51E0),
                          onPressed: () => controller.DoGoogleLogin()),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                      width: 170,
                      height: 50,
                      child: QButton(
                          label: "SignUp",
                          color: Color(0xFF9B51E0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpFormView()),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => {},
                      child: Text(
                        "Forgot your password?",
                        style:
                            TextStyle(color: Color(0xFF9B51E0), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  State<LoginFormView> createState() => LoginFormController();
}
