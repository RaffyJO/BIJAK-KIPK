import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;
    Future<List<DocumentSnapshot>> getExpenseDataByCurrentUser() async {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String currentUserId = currentUser.uid;

        QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
            .collection("datadiri")
            .where("user.uid", isEqualTo: currentUserId)
            .get();

        return expenseSnapshot.docs;
      } else {
        return [];
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF9B51E0),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              controller.Dologout();
            },
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 110.0,
            ),
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF9B51E0),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  backgroundImage: AssetImage(
                    FirebaseAuth.instance.currentUser!.photoURL ??
                        "assets/aset/logo.png",
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName ??
                            "Jacob",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email ?? "none",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
          ),
          FutureBuilder<List<DocumentSnapshot>>(
            future: getExpenseDataByCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                List<DocumentSnapshot> expenseDocuments = snapshot.data ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: expenseDocuments.map((document) {
                    String kip_number = document["kip_number"];
                    String university = document["university"];
                    String major = document["major"];

                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "KIP-K number",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  kip_number,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "University",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  university,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Major",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  major,
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
