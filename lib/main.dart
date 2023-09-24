import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/module/login_form/view/login_form_view.dart';
import 'package:hyper_ui/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capek Ngoding',
      // navigatorKey: Get.navigatorKey,3
      debugShowCheckedModeBanner: false,
      // theme: getDefaultTheme()

      home: LoginFormView(),
    );
  }
}
