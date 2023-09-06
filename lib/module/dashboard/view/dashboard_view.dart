import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

import '../../expense_page/expense_detail_page.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
    Widget expenseItem() {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ExpenseDetailPage(),
              ))
              .then((value) {});
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

    controller.view = this;
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF9B51E0),
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Color(0xFF9B51E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Text(
                        "Welcome back, Jacob!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Expanded(
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 245, 245),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Spennding on June 2022",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  "325.000.000",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Builder(
                builder: (context) {
                  final List<Map<String, dynamic>> chartData = [
                    {
                      "month": "January",
                      "sales": 40,
                    },
                    {
                      "month": "February",
                      "sales": 90,
                    },
                    {
                      "month": "Maret",
                      "sales": 30,
                    },
                    {
                      "month": "April",
                      "sales": 80,
                    },
                    {
                      "month": "Mei",
                      "sales": 150,
                    },
                    {
                      "month": "Juni",
                      "sales": 150,
                    },
                    {
                      "month": "July",
                      "sales": 150,
                    },
                    {
                      "month": "Agustus",
                      "sales": 150,
                    },
                    {
                      "month": "September",
                      "sales": 150,
                    },
                    {
                      "month": "Oktober",
                      "sales": 150,
                    },
                    {
                      "month": "November",
                      "sales": 150,
                    },
                    {
                      "month": "Desember",
                      "sales": 150,
                    },
                  ];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).cardColor,
                          padding: EdgeInsets.all(12.0),
                          child: ListView.builder(
                            itemCount:
                                chartData.length > 12 ? 12 : chartData.length,
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              final data = chartData[index];
                              return Container(
                                width: 60,
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 25 * data["sales"] / 17,
                                      width: 70,
                                      color: Color(0xFF9B51E0),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                        height: 25,
                                        child: Text(
                                          data["month"],
                                          style: TextStyle(fontSize: 12),
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 76.0,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var item = {};
                    List<String> nama = ['Primer', 'Pendidikan', 'Sekuder'];
                    return Container(
                      width: 160,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${nama[index]}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            Container(
                              child: Text(
                                "Rp.94,000,000",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            expenseItem(),
            expenseItem(),
            expenseItem(),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
