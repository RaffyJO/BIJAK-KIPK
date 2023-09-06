import 'package:flutter/material.dart';
import 'package:hyper_ui/module/expense_page/add_expense_page.dart';
import 'package:hyper_ui/module/expense_page/expense_detail_page.dart';
import 'package:hyper_ui/module/expense_page/object/expense_item.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF9B51E0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Text(
                            "Expense",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                  ],
                ),
              ),
              searchBox(),
              Expanded(
                  child: ListView(
                children: [
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                ],
              )),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    margin: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => AddExpensePage(),
                        ))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9B51E0),
          


                        // minimumSize: const Size(120, 60),
                        elevation: 10,
                      ),
                      child: const Text(
                        'Add new expense',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  
  Widget searchBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: const TextField(
        // onChanged: ((value) => _runFilter(value)),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            border: InputBorder.none,
            hintText: 'Search report...',
            hintStyle: TextStyle(
              color: Colors.grey,
            )),
      ),
    );
  }
}
