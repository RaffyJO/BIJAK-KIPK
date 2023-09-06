import 'package:flutter/material.dart';
import 'package:hyper_ui/module/transaction_page/object/report.dart';
import 'package:hyper_ui/module/transaction_page/report_detail_page.dart';
import 'package:hyper_ui/shared/theme/theme_config.dart';

class ReportItem extends StatefulWidget {
  final Report report;
  // final onToDoChanged;
  // final onDeleteItem;

  const ReportItem({
    super.key,
    required this.report,
    // required this.onToDoChanged,
    // required this.onDeleteItem
  });

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
  void openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Penyalahgunaan KIP-K 1",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Are you sure to delete this report?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          elevation: 10,
                        ),
                        onPressed: () {},
                        child: Text("Cancel"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 10,
                        ),
                        onPressed: () {},
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
          builder: (context) => ReportDetailPage(),
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, elevation: 0),
                    onPressed: () {},
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    )),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, elevation: 0),
                    onPressed: () {
                      openDialog();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )),
              ],
            ),
            title: Text("Teks"),
          ),
        ),
      ),
    );
  }
}
