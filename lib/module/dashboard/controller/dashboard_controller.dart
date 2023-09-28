import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/dashboard/view/dashboard_view2.dart';

import '../view/chart_data_model.dart';

class DashboardController extends State<DashboardView2> {
  static late DashboardController instance;
  late DashboardView2 view;
  List<Map<String, dynamic>> chartData = ChartDataModel.chartData;
  int selectedIndex = -1;
  get products => null;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  int selectedChartIndex = 0;

  void selectChart(int index) {
    setState(() {
      selectedChartIndex = index;
    });
  }

  @override
  void dispose() => super.dispose();

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
