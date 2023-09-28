// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// Future<List<Map<String, dynamic>>>
//     getTotalExpenseAmountByMonthAndCategory() async {
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   if (currentUser != null) {
//     String currentUserId = currentUser.uid;

//     QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
//         .collection("expense")
//         .where("user.uid", isEqualTo: currentUserId)
//         .get();

//     // Inisialisasi list map untuk setiap bulan
//     List<Map<String, dynamic>> result = [];

//     // Iterasi melalui dokumen-dokumen yang ditemukan
//     for (QueryDocumentSnapshot document in expenseSnapshot.docs) {
//       String category = document["category"]; // Dapatkan kategori dari dokumen
//       num expenseAmount =
//           document["amount"] ?? 0.0; // Dapatkan jumlah pengeluaran
//       String rawDate =
//           document["datebaru"]; // Tanggal bulan dan tahun dari Firestore
//       DateTime date = DateTime.parse(rawDate); // Konversi ke objek DateTime

//       String month = DateFormat.MMMM()
//           .format(date); // Menggunakan intl untuk mendapatkan nama bulan

//       // String month = document["datebaru"]; // Dapatkan bulan dari dokumen

//       // Cari indeks bulan dalam list result
//       int monthIndex =
//           result.indexWhere((element) => element['datebaru'] == month);

//       if (monthIndex == -1) {
//         // Jika bulan belum ada, tambahkan map baru ke result
//         Map<String, dynamic> monthData = {
//           'month': month,
//           'data': {
//             'primer': 0.0,
//             'sekunder': 0.0,
//             'tersier': 0.0,
//             'pendidikan': 0.0,
//           },
//         };
//         result.add(monthData);
//         monthIndex = result.length - 1; // Perbarui indeks bulan
//       }

//       // Tambahkan nilai pengeluaran ke kategori yang sesuai
//       result[monthIndex]['data'][category] += expenseAmount;
//     }

//     return result;
//   } else {
//     // Handle kasus jika pengguna belum masuk atau tidak ada pengguna saat ini
//     return [];
//   }
// }

// class ExpenseApp extends StatefulWidget {
//   @override
//   _ExpenseAppState createState() => _ExpenseAppState();
// }

// class _ExpenseAppState extends State<ExpenseApp> {
//   List<Map<String, dynamic>> expenseData = []; // Menyimpan data pengeluaran

//   @override
//   void initState() {
//     super.initState();
//     // Panggil fungsi untuk mengambil data pengeluaran
//     _fetchExpenseData();
//   }

//   Future<void> _fetchExpenseData() async {
//     List<Map<String, dynamic>> data =
//         await getTotalExpenseAmountByMonthAndCategory();
//     setState(() {
//       expenseData = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Aplikasi Pengeluaran'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Tampilkan data pengeluaran di sini sesuai kebutuhan Anda
//             // Misalnya, dapat Anda tampilkan dalam ListView atau DataTable
//             // Sesuaikan dengan struktur data yang telah Anda buat.

//             // Contoh: Tampilkan bulan dan data pengeluaran untuk setiap bulan
//             for (var entry in expenseData)
//               Column(
//                 children: [
//                   Text('Bulan: ${entry['month']}'),
//                   Text('Primer: ${entry['data']['primer']}'),
//                   Text('Sekunder: ${entry['data']['sekunder']}'),
//                   Text('Tersier: ${entry['data']['tersier']}'),
//                   Text('Pendidikan: ${entry['data']['pendidikan']}'),
//                   Divider(), // Pemisah antara setiap bulan
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<List<Map<String, dynamic>>>
    getTotalExpenseAmountByMonthAndCategory() async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    String currentUserId = currentUser.uid;

    QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
        .collection("expense")
        .where("user.uid", isEqualTo: currentUserId)
        .get();

    List<Map<String, dynamic>> result = [];

    for (QueryDocumentSnapshot document in expenseSnapshot.docs) {
      String category = document["category"];
      num expenseAmount = document["amount"] ?? 0.0;
      String rawDate = document["datebaru"];
      DateTime date = DateTime.parse(rawDate);

      String month = DateFormat.MMMM('id_ID')
          .format(date); // Format dalam bahasa Indonesia

      int monthIndex =
          result.indexWhere((element) => element['month'] == month);

      if (monthIndex == -1) {
        Map<String, dynamic> monthData = {
          'month': month,
          'data': {
            'primer': 0.0,
            'sekunder': 0.0,
            'tersier': 0.0,
            'pendidikan': 0.0,
          },
        };
        result.add(monthData);
        monthIndex = result.length - 1;
      }

      result[monthIndex]['data'][category] += expenseAmount;
    }

    return result;
  } else {
    return [];
  }
}

class ExpenseApp extends StatefulWidget {
  @override
  _ExpenseAppState createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  List<Map<String, dynamic>> expenseData = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenseData();
  }

  Future<void> _fetchExpenseData() async {
    List<Map<String, dynamic>> data =
        await getTotalExpenseAmountByMonthAndCategory();
    setState(() {
      expenseData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Pengeluaran'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var entry in expenseData)
                Column(
                  children: [
                    Text('Bulan: ${entry['month']}'),
                    Text('Primer: ${entry['data']['primer']}'),
                    Text('Sekunder: ${entry['data']['sekunder']}'),
                    Text('Tersier: ${entry['data']['tersier']}'),
                    Text('Pendidikan: ${entry['data']['pendidikan']}'),
                    Divider(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
