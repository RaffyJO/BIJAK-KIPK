import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class DataDiriView extends StatefulWidget {
  const DataDiriView({Key? key}) : super(key: key);

  Widget build(context, DataDiriController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Data Diri'),
        backgroundColor: Color(0xFF9B51E0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Data Diri"),
            SizedBox(
              height: 15,
            ),
            QNumberField(
              label: "KIP Number",
              validator: Validator.required,
              onChanged: (value) {
                controller.kip_number = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "University",
              validator: Validator.required,
              onChanged: (value) {
                controller.university = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "major",
              validator: Validator.required,
              onChanged: (value) {
                controller.major = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "Password",
              validator: Validator.required,
              onChanged: (value) {
                controller.password = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "Confirm Password",
              validator: Validator.required,
              onChanged: (value) {
                controller.confirm_password = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  controller.saveDataDiri(user);
                }
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Simpan Data Diri'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<DataDiriView> createState() => DataDiriController();
}
