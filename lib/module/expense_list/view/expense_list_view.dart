import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ExpenseListView extends StatefulWidget {
  const ExpenseListView({Key? key}) : super(key: key);

  Future<List<DocumentSnapshot>> getExpenseDataByCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      return expenseSnapshot.docs;
    } else {
      // Handle kasus jika pengguna belum masuk atau tidak ada pengguna saat ini
      return [];
    }
  }

  Widget build(context, ExpenseListController controller) {
    controller.view = this;

    return Scaffold(
      body: Stack(
        children: [
          // StreamBuilder<QuerySnapshot>(
          //   stream:
          //       FirebaseFirestore.instance.collection("expense").snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) return const Text("Error");
          //     if (snapshot.data == null) return Container();
          //     if (snapshot.data!.docs.isEmpty) {
          //       return const Text("No Data");
          //     }
          //     final data = snapshot.data!;
          //     return ListView.builder(
          //       itemCount: data.docs.length,
          //       padding: EdgeInsets.zero,
          //       clipBehavior: Clip.none,
          //       itemBuilder: (context, index) {
          //         Map<String, dynamic> item =
          //             (data.docs[index].data() as Map<String, dynamic>);
          //         item["id"] = data.docs[index].id;
          //         var createAt = item["date"];
          //         var dates = (createAt as Timestamp).toDate();
          //         return Card(
          //           child: ListTile(
          //             title: Text(item["name"]),
          //             subtitle: Text("$dates"),
          //             trailing: Column(
          //               children: [
          //                 Text(
          //                   item["category"],
          //                   style: TextStyle(
          //                     fontSize: 10.0,
          //                   ),
          //                 ),
          //                 Text(
          //                   "amount",
          //                   style: TextStyle(
          //                     fontSize: 10.0,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          FutureBuilder<List<DocumentSnapshot>>(
            future: getExpenseDataByCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                List<DocumentSnapshot> expenseDocuments = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: expenseDocuments.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = expenseDocuments[index];
                    var createAt = document["date"];
                    var dates = (createAt as Timestamp).toDate();
                    String name = document["name"];
                    String category = document["category"];
                    String itemName = document["itemName"];
                    String photo = document["photo"];

                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpenseDetailPage()),
                      ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                              photo,
                            ),
                          ),
                          title: Text(name),
                          subtitle: Text("$dates"),
                          trailing: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  State<ExpenseListView> createState() => ExpenseListController();
}
