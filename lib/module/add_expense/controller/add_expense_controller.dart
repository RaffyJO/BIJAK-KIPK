import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class AddExpenseController extends State<AddExpensePageView> {
  static late AddExpenseController instance;
  late AddExpensePageView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String nama = "";
  String category = "";
  int? categor = 0;
  var categori = {1: 'primer', 2: 'sekunder', 3: 'tersier', 4: 'pendidikan'};
  String itemName = "";
  DateTime? date;
  num? amount = 0;
  String photo = "";

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  DoAddExpense() async {
    if (nama.isEmpty || category.isEmpty || itemName.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Kesalahan'),
            content: Text('Harap lengkapi semua data yang diperlukan.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (amount == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Kesalahan'),
            content: Text('Harap masukkan amount yang tepat'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      String month = DateFormat('MMMM').format(date!);
      await FirebaseFirestore.instance.collection("expense").add({
        "name": nama,
        "category": category,
        "datebaru": date,
        "date": Timestamp.now(),
        "bulan": month,
        "itemName": itemName,
        "amount": amount,
        "photo": photo,
        "user": {
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "name": FirebaseAuth.instance.currentUser!.displayName,
          "email": FirebaseAuth.instance.currentUser!.email
        }
      });
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Tambahkan Data'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9B51E0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/homeExpense');
                },
                child: Text("Yes"),
              ),
            ],
          );
        },
      );
    }
  }
}
