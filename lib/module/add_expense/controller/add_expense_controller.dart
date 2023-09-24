import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class AddExpenseController extends State<AddExpensePageView> {
  static late AddExpenseController instance;
  late AddExpensePageView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String nama = "";
  String category = "";
  String itemName = "";
  String date = "";
  num? amount = 0;
  String photo = "";

  DoAddExpense() async {
    await FirebaseFirestore.instance.collection("expense").add({
      "name": nama,
      "category": category,
      "date": Timestamp.now(),
      "itemName": itemName,
      "amount": amount,
      "photo": photo,
      "user": {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "name": FirebaseAuth.instance.currentUser!.displayName,
        "email": FirebaseAuth.instance.currentUser!.email
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FloatMainNavigationView()),
    );
  }
}
