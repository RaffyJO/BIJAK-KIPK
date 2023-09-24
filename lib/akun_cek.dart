import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore
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
            return LoginFormView();
          } else {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('datadiri')
                  .doc(user.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> dataDiriSnapshot) {
                if (dataDiriSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                } else if (dataDiriSnapshot.hasError) {
                  print('Error: ${dataDiriSnapshot.error}');
                  return Text('Error: ${dataDiriSnapshot.error}');
                } else {
                  if (dataDiriSnapshot.data != null &&
                      dataDiriSnapshot.data!.exists) {
                    String? major = dataDiriSnapshot.data!.get('major');

                    if (major != null) {
                      return FloatMainNavigationView(
                        initialSelectedIndex: 0,
                      );
                    } else {
                      // Pengguna tidak memiliki data major atau data tidak valid
                      // Tampilkan DataDiriView untuk mengisi data
                      return DataDiriView(); // Sesuaikan dengan tampilan yang Anda inginkan
                    }
                  } else {
                    // Pengguna tidak memiliki data diri
                    // Tampilkan DataDiriView untuk mengisi data
                    return DataDiriView(); // Sesuaikan dengan tampilan yang Anda inginkan
                  }
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
