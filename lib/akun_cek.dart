// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class akunCek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _akun = FirebaseAuth.instance;

    return StreamBuilder(
      stream: _akun.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            // Pengguna belum masuk, arahkan ke layar masuk atau halaman autentikasi.
            return LoginFormView();
          } else {
            // Pengguna sudah masuk, arahkan ke halaman utama aplikasi.
            return FloatMainNavigationView(
              initialSelectedIndex: 0,
            );
          }
        }

        // Tampilkan indikator loading atau widget lain selama proses cek autentikasi.
        return CircularProgressIndicator();
      },
    );
  }
}
