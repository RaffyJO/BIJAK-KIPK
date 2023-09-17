import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/dashboard/view/dashboard_view2.dart';

import '../view/chart_data_model.dart';
import '../view/dashboard_view.dart';

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
  String name = FirebaseAuth.instance.currentUser!.displayName ??
      FirebaseAuth.instance.currentUser!.email ??
      "Jacob";
}
