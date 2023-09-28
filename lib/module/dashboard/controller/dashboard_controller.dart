import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/dashboard/view/dashboard_view2.dart';

class DashboardController extends State<DashboardView2> {
  static late DashboardController instance;
  late DashboardView2 view;
  late Future<Map<String, int>> _categoryTotals;

  @override
  void initState() {
    super.initState();
    _categoryTotals = getTotalExpenseByCategory();
  }

  Future<Map<String, int>> getTotalExpenseByCategory() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      Map<String, int> categoryTotals = {};

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      expenseSnapshot.docs.forEach((doc) {
        String category = doc['category'];
        int expenseAmount = doc['amount'];

        categoryTotals.update(
          category,
          (value) => value + expenseAmount,
          ifAbsent: () => expenseAmount,
        );
      });

      return categoryTotals;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  String name = FirebaseAuth.instance.currentUser!.displayName ??
      FirebaseAuth.instance.currentUser!.email ??
      "Jacob";
}
