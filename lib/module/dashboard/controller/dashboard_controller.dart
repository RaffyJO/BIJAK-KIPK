import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/dashboard/view/dashboard_view2.dart';

class DashboardController extends State<DashboardView2> {
  static late DashboardController instance;
  late DashboardView2 view;
  final _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUser?.uid)
          .get();

      List<Map<String, dynamic>> data = [];
      querySnapshot.docs.forEach((document) {
        String month = document['bulan'];
        num amount = document['amount'];
        String category = document['category'];

        int existingIndex = data.indexWhere((entry) => entry['month'] == month);

        if (existingIndex != -1) {
          if (category == "primer") {
            data[existingIndex]['data']['primer'] += amount;
          } else if (category == "sekunder") {
            data[existingIndex]['data']['sekunder'] += amount;
          } else if (category == "tersier") {
            data[existingIndex]['data']['tersier'] += amount;
          } else if (category == "pendidikan") {
            data[existingIndex]['data']['pendidikan'] += amount;
          }
        } else {
          Map<String, dynamic> newData = {
            'month': month,
            'data': {
              'primer': category == "primer" ? amount : 0,
              'sekunder': category == "sekunder" ? amount : 0,
              'tersier': category == "tersier" ? amount : 0,
              'pendidikan': category == "pendidikan" ? amount : 0,
            },
          };
          data.add(newData);
        }
      });

      setState(() {
        chartData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = FirebaseAuth.instance.currentUser!.displayName ??
      FirebaseAuth.instance.currentUser!.email ??
      "";

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
