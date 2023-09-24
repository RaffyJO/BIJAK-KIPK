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
  String major = "";
  String password = "";
  String confirm_password = "";
  String university = "";

  Future<void> saveDataDiri(User user) async {
    await FirebaseFirestore.instance.collection("datadiri").add({
      'kip_number': kip_number,
      'password': password,
      'university': university,
      'major': kip_number,
      'email': FirebaseAuth.instance.currentUser!.email,
      'nama': FirebaseAuth.instance.currentUser!.displayName,
      'user': {'uid': FirebaseAuth.instance.currentUser!.uid}
    }).then((_) {
      print('Data diri disimpan');
    }).catchError((error) {
      print('Error saat menyimpan data diri: $error');
    });
  }
}
