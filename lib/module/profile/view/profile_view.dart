import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/module/akun/item/akunDataModel.dart';

import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;
    final akunData = akunDataModel.akunData;
    final name = akunData[0]["id"]["nama"];
    final email = akunData[0]["id"]["email"];

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
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
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
                      "assets/aset/akun.jpg",
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
                          "$name",
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
                          "$email",
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
          ],
        ),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
