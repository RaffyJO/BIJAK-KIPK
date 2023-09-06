import 'package:flutter/material.dart';
import 'package:hyper_ui/module/expense_page/expense_detail_page.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem({super.key});

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
          builder: (context) => ExpenseDetailPage(),
        ))
            .then((value) {
          setState(() {});
        });
        ;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 1,
          child: ListTile(
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Primer",
                  style: TextStyle(color: Color(0xFF9B51E0)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Rp50,000,000"),
              ],
            ),
            title: Text("Pembayaran Kost"),
            subtitle: Text("18 Agustus 2023"),
          ),
        ),
      ),
    );
  }
}