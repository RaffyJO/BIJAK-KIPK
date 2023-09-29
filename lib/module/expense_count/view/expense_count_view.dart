import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/expense_count_controller.dart';

class ExpenseCountView extends StatefulWidget {
  const ExpenseCountView({Key? key}) : super(key: key);

  Widget build(context, ExpenseCountController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpenseCount"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }

  @override
  State<ExpenseCountView> createState() => ExpenseCountController();
}
