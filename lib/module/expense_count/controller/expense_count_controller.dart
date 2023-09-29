import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/expense_count_view.dart';

class ExpenseCountController extends State<ExpenseCountView> {
  static late ExpenseCountController instance;
  late ExpenseCountView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
