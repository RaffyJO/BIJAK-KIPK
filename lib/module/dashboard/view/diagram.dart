import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  final _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUser?.uid)
          .get();

      List<Map<String, dynamic>> data = [];
      querySnapshot.docs.forEach((document) {
        String month = document['bulan'];
        num amount = document['amount'];
        String category = document['category'];

        int existingIndex = data.indexWhere((entry) => entry['month'] == month);

        if (existingIndex != -1) {
          if (category == "primer") {
            data[existingIndex]['data']['primer'] += amount;
          } else if (category == "sekunder") {
            data[existingIndex]['data']['sekunder'] += amount;
          } else if (category == "tersier") {
            data[existingIndex]['data']['tersier'] += amount;
          } else if (category == "pendidikan") {
            data[existingIndex]['data']['pendidikan'] += amount;
          }
        } else {
          Map<String, dynamic> newData = {
            'month': month,
            'data': {
              'primer': category == "primer" ? amount : 0,
              'sekunder': category == "sekunder" ? amount : 0,
              'tersier': category == "tersier" ? amount : 0,
              'pendidikan': category == "pendidikan" ? amount : 0,
            },
          };
          data.add(newData);
        }
      });

      setState(() {
        chartData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: chartData.length > 12 ? 12 : chartData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = chartData[index];
                      return InkWell(
                        onTap: () {
                          showDetail(data);
                        },
                        child: Container(
                          height: 100,
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: (data["data"]["primer"] +
                                              data["data"]["sekunder"] +
                                              data["data"]["tersier"] +
                                              data["data"]["pendidikan"]) *
                                          data["data"]["primer"] /
                                          300000000,
                                      width: 20,
                                      color: Colors.blue,
                                    ),
                                    Container(
                                      height: (data["data"]["primer"] +
                                              data["data"]["sekunder"] +
                                              data["data"]["tersier"] +
                                              data["data"]["pendidikan"]) *
                                          data["data"]["sekunder"] /
                                          300000000,
                                      width: 20,
                                      color: Colors.yellow,
                                    ),
                                    Container(
                                      height: (data["data"]["primer"] +
                                              data["data"]["sekunder"] +
                                              data["data"]["tersier"] +
                                              data["data"]["pendidikan"]) *
                                          data["data"]["tersier"] /
                                          300000000,
                                      width: 20,
                                      color: Colors.red,
                                    ),
                                    Container(
                                      height: (data["data"]["primer"] +
                                              data["data"]["sekunder"] +
                                              data["data"]["tersier"] +
                                              data["data"]["pendidikan"]) *
                                          data["data"]["pendidikan"] /
                                          300000000,
                                      width: 20,
                                      color: Colors.green,
                                    ),
                                  ]),
                              SizedBox(height: 15.0),
                              Container(
                                  height: 25,
                                  child: Text(
                                    data["month"],
                                    style: TextStyle(fontSize: 15),
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
    );
  }

  void showDetail(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detail Data - ${data['month']}"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Primer: ${data['data']['primer']}"),
              Text("Sekunder: ${data['data']['sekunder']}"),
              Text("Tersier: ${data['data']['tersier']}"),
              Text("Pendidikan: ${data['data']['pendidikan']}"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}
