import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/expense_list_view.dart';

class ExpenseListController extends State<ExpenseListView> {
  static late ExpenseListController instance;
  late ExpenseListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  Add() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => AddExpensePageView(),
    ))
        .then((value) {
      setState(() {});
    });
  }

  Future<List<DocumentSnapshot>> getExpenseDataByCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      return expenseSnapshot.docs;
    } else {
      // Handle kasus jika pengguna belum masuk atau tidak ada pengguna saat ini
      return [];
    }
  }
}
