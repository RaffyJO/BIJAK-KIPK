import 'package:flutter/material.dart';

import '../view/chart_data_model.dart';
import '../view/dashboard_view.dart';

class DashboardController extends State<DashboardView> {
  static late DashboardController instance;
  late DashboardView view;
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
}
