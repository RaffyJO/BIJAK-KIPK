import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/dashboard/view/dashboard_view2.dart';
import '../view/chart_data_model.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> calculateTotalAmount() async {
    String userId;
    final user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
    } else {
      // Handle jika pengguna belum masuk
      return 0.0;
    }

    List<String> categoriesToSum = [
      'primer',
      'sekunder',
      'tersier',
      'pendidikan'
    ];

    QuerySnapshot querySnapshot = await _firestore
        .collection('expense')
        .where('user', isEqualTo: userId)
        .where('category', whereIn: categoriesToSum)
        .get();

    double total = 0;
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null && data['amount'] != null) {
        total += data['amount'];
      }
    }

    return total;
  }
}
