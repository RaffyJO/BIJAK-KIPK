import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

import '../view/data_diri_view.dart';

class DataDiriController extends State<DataDiriView> {
  static late DataDiriController instance;
  late DataDiriView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String kip_number = "";
  String nama = "";
  String major = "";
  String display = "";
  String photo = "";
  String confirm_password = "";
  String university = "";

  Future<void> saveDataDiri(User user) async {
    if (kip_number.isEmpty ||
        university.isEmpty ||
        photo.isEmpty ||
        major.isEmpty ||
        nama.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Kesalahan"),
          content: Text("Harap lengkapi semua data yang diperlukan."),
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
    } else {
      try {
        display = nama;
        final FirebaseAuth _auth = FirebaseAuth.instance;
        display = _auth.currentUser?.displayName ?? '';
        await FirebaseFirestore.instance.collection("datadiri").add({
          'kip_number': kip_number,
          'university': university,
          'photo': photo,
          'major': major,
          'email': FirebaseAuth.instance.currentUser!.email,
          'nama': nama,
          'user': {'uid': FirebaseAuth.instance.currentUser!.uid}
        }).then((_) {
          Navigator.pushReplacementNamed(context, '/home');
        }).catchError((error) {
          print('Error saat menyimpan data diri: $error');
        });
      } catch (e) {}
    }
  }
}
