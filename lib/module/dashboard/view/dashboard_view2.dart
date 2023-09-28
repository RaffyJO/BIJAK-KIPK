import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/decorator.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/commons/style.dart';
import 'package:d_chart/ordinal/combo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class DashboardView2 extends StatefulWidget {
  DashboardView2({Key? key}) : super(key: key);
  Future<Map<String, int>> getTotalExpenseByCategory() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      Map<String, int> categoryTotals = {};

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      expenseSnapshot.docs.forEach((doc) {
        String category = doc['category'];
        int expenseAmount = doc['amount'];

        categoryTotals.update(
          category,
          (value) => value + expenseAmount,
          ifAbsent: () => expenseAmount,
        );
      });

      return categoryTotals;
    } else {
      return {};
    }
  }

  late Future<Map<String, int>> _categoryTotals = getTotalExpenseByCategory();

  Widget build(context, DashboardController controller) {
    final now = DateTime.now();
    final monthFormat = DateFormat.MMMM();
    final monthName = monthFormat.format(now);
    String monthnow = monthName;
    final chartData = ChartDataModel.chartData;

    controller.view = this;
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF9B51E0),
        title: const Text("Dashboard"),
      ),
      body: FutureBuilder<Map<String, int>>(
          future: _categoryTotals,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      color: Color(0xFF9B51E0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Text(
                                "Welcome Back " + controller.name,
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
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Text(
                                        "Spending on $monthnow 2023",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Rp.0",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Builder(
                        builder: (context) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).cardColor,
                                  padding: EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    itemCount: chartData.length > 12
                                        ? 12
                                        : chartData.length,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      final data = chartData[index];
                                      return InkWell(
                                        onTap: () {
                                          openChart(context, snapshot);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 80,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["primer"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.blue,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["sekunder"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.yellow,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["tersier"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.red,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["pendidikan"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.green,
                                                    ),
                                                  ]),
                                              SizedBox(height: 15.0),
                                              Container(
                                                  height: 25,
                                                  child: Text(
                                                    data["month"],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )),
                                            ],
                                          ),
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
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengeluaran di Bulan $monthName",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                          height: 76.0,
                          child: ListView.builder(
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Container(
                                  width: 160,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Belum Ada Pengeluaran",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      color: Color(0xFF9B51E0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Text(
                                "Welcome Back " + controller.name,
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
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Text(
                                        "Spending on $monthnow 2023",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            final category = snapshot.data?.keys
                                                .elementAt(index);
                                            final total =
                                                snapshot.data?[category];
                                            // Membuat variabel total
                                            int overallTotal = 0;
                                            // Mengakses data dari snapshot
                                            final categoryTotals =
                                                snapshot.data;
                                            // Melakukan penjumlahan
                                            if (categoryTotals != null) {
                                              categoryTotals
                                                  .forEach((category, total) {
                                                overallTotal += total;
                                              });
                                            }
                                            return Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Rp.$overallTotal",
                                                style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Builder(
                        builder: (context) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Theme.of(context).cardColor,
                                  padding: EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    itemCount: chartData.length > 12
                                        ? 12
                                        : chartData.length,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      final data = chartData[index];
                                      return InkWell(
                                        onTap: () {
                                          openChart(context, snapshot);
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 80,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["primer"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.blue,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["sekunder"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.yellow,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["tersier"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.red,
                                                    ),
                                                    Container(
                                                      height: (data["data"]
                                                                  ["primer"] +
                                                              data["data"]
                                                                  ["sekunder"] +
                                                              data["data"]
                                                                  ["tersier"] +
                                                              data["data"][
                                                                  "pendidikan"]) *
                                                          data["data"]
                                                              ["pendidikan"] /
                                                          40000000,
                                                      width: 20,
                                                      color: Colors.green,
                                                    ),
                                                  ]),
                                              SizedBox(height: 15.0),
                                              Container(
                                                  height: 25,
                                                  child: Text(
                                                    data["month"],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )),
                                            ],
                                          ),
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
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengeluaran di Bulan $monthName",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                          height: 76.0,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // final data = chartData.firstWhere(
                              //     (element) => element["month"] == "$monthnow");
                              // List<String> kebutuhan = [
                              //   'Primer',
                              //   'Sekunder',
                              //   'Tersier',
                              //   'Pendidikan'
                              // ];
                              final category =
                                  snapshot.data?.keys.elementAt(index);
                              final total = snapshot.data?[category];

                              return Row(children: [
                                Container(
                                  width: 160,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          total!.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpenseItem(),
                    ExpenseItem(),
                    ExpenseItem(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  @override
  State<DashboardView2> createState() => DashboardController();
}

void openChart(BuildContext context, snapshot) {
  final primer = snapshot.data?.keys
      .firstWhere((key) => key == 'Primer', orElse: () => '');
  final sekunder = snapshot.data?.keys
      .firstWhere((key) => key == 'Sekunder', orElse: () => '');
  final tersier = snapshot.data?.keys
      .firstWhere((key) => key == 'Tersier', orElse: () => '');
  final pendidikan = snapshot.data?.keys
      .firstWhere((key) => key == 'Pendidikan', orElse: () => '');
  final totPrimer = snapshot.data?[primer] ?? 0;
  final totSekunder = snapshot.data?[sekunder] ?? 0;
  final totTersier = snapshot.data?[tersier] ?? 0;
  final totPendidikan = snapshot.data?[pendidikan] ?? 0;
  final now = DateTime.now();
  final monthFormat = DateFormat.MMMM();
  final chartData = ChartDataModel.chartData;
  final currentMonth = monthFormat.format(now);
  String monthNow = currentMonth;
  Map<String, dynamic>? monthData;
  for (final data in chartData) {
    if (data["month"] == "$monthNow") {
      monthData = data;
      break;
    }
  }
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(monthNow),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartComboO(
                        barLabelDecorator: BarLabelDecorator(
                            barLabelPosition: BarLabelPosition.outside),
                        barLabelValue: (group, ordinalData, index) {
                          return 'Rp.${ordinalData.measure}';
                        },
                        outsideBarLabelStyle: (group, ordinalData, index) {
                          return const LabelStyle(
                            fontSize: 8,
                          );
                        },
                        groupList: [
                          OrdinalGroup(
                              id: '1',
                              chartType: ChartType.bar,
                              data: [
                                OrdinalData(
                                    domain: 'Primer', measure: totPrimer),
                                OrdinalData(
                                    domain: 'Sekunder', measure: totSekunder),
                                OrdinalData(
                                    domain: 'Tersier', measure: totTersier),
                                OrdinalData(
                                    domain: 'Pendidikan',
                                    measure: totPendidikan),
                              ]),
                        ]),
                  ),
                ),
                SizedBox(width: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 80,
                          color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      });
}
