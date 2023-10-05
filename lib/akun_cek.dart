import 'package:cloud_firestore/cloud_firestore.dart';
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
            // Jika belum masuk, arahkan ke LoginFormView
            return LoginFormView();
          } else {
            // Jika sudah masuk, periksa data di koleksi "datadiri"
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('datadiri')
                  .doc(user.uid)
                  .get(),
              builder: (context, dataDiriSnapshot) {
                if (dataDiriSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }

                if (dataDiriSnapshot.hasError) {
                  return Text("Error: ${dataDiriSnapshot.error}");
                }

                final data =
                    dataDiriSnapshot.data?.data() as Map<String, dynamic>?;
                final major = data?['major'];
                final nama = data?['nama'];
                final nomorKipk = data?['kip_number'];

                if (major == null || nama == null || nomorKipk == null) {
                  // Jika ada yang belum terisi, arahkan ke DataDiriView
                  return DataDiriView();
                } else {
                  // Jika semua data terisi, arahkan ke FloatMainNavigationView
                  return FloatMainNavigationView(
                    initialSelectedIndex: 0,
                  );
                }
              },
            );
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
