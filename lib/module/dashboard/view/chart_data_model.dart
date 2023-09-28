import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChartDataModel {
  // Future<double> getTotalExpenseAmountInCategory(String category) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;

  //   if (currentUser != null) {
  //     String currentUserId = currentUser.uid;

  //     QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
  //         .collection("expense")
  //         .where("user.uid", isEqualTo: currentUserId)
  //         .where("category", isEqualTo: category)
  //         .get();

  //     double totalAmount = 0.0; // Inisialisasi totalAmount sebagai 0

  //     // Iterasi melalui dokumen-dokumen yang ditemukan
  //     for (QueryDocumentSnapshot document in expenseSnapshot.docs) {
  //       // Ambil nilai numerik dari bidang "amount" dalam dokumen
  //       double expenseAmount =
  //           document["amount"] ?? 0.0; // Default 0 jika bidang tidak ada

  //       // Tambahkan nilai ke totalAmount
  //       totalAmount += expenseAmount;
  //     }

  //     return totalAmount;
  //   } else {
  //     // Handle kasus jika pengguna belum masuk atau tidak ada pengguna saat ini
  //     return 0.0; // Kembalikan 0 jika tidak ada data
  //   }
  // }

  Future<List<Map<String, dynamic>>>
      getTotalExpenseAmountByMonthAndCategory() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      // Inisialisasi list map untuk setiap bulan
      List<Map<String, dynamic>> result = [];

      // Iterasi melalui dokumen-dokumen yang ditemukan
      for (QueryDocumentSnapshot document in expenseSnapshot.docs) {
        String category =
            document["category"]; // Dapatkan kategori dari dokumen
        double expenseAmount =
            document["amount"] ?? 0.0; // Dapatkan jumlah pengeluaran
        String month = document["datebaru"]; // Dapatkan bulan dari dokumen

        // Cari indeks bulan dalam list result
        int monthIndex =
            result.indexWhere((element) => element['month'] == month);

        if (monthIndex == -1) {
          // Jika bulan belum ada, tambahkan map baru ke result
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
          monthIndex = result.length - 1; // Perbarui indeks bulan
        }

        // Tambahkan nilai pengeluaran ke kategori yang sesuai
        result[monthIndex]['data'][category] += expenseAmount;
      }

      return result;
    } else {
      // Handle kasus jika pengguna belum masuk atau tidak ada pengguna saat ini
      return [];
    }
  }

  // Future<Map<String, int>> getTotalByCategory() async {
  //   Map<String, int> categoryTotal = {};

  //   // Mengambil koleksi dari Firebase Firestore
  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('expense').get();

  //   // Loop melalui dokumen-dokumen dan menjumlahkan nilai berdasarkan kategori
  //   for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //     String? kategori = doc['category'];
  //     int? nilaiField = doc['amount'];

  //     // Periksa apakah kategori dan nilaiField null sebelum melakukan penjumlahan
  //     if (kategori != null && nilaiField != null) {
  //       categoryTotal[kategori] = (categoryTotal[kategori] ?? 0) + nilaiField;
  //     }
  //   }

  //   return categoryTotal;
  // }

  // static num hargaPrimer = 2;
  // num hargaSekunder = 0;
  // num hargaTersier = 0;
  // num hargaPendidikan = 0;

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: FutureBuilder<List<DocumentSnapshot>>(
  //     future: getExpenseDataByCurrentUserAndCategory(String Primer),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         return Text("Error: ${snapshot.error}");
  //       } else {
  //         List<DocumentSnapshot> expenseDocuments = snapshot.data ?? [];

  //         return ListView.builder(
  //           itemCount: expenseDocuments.length,
  //           itemBuilder: (context, index) {
  //             DocumentSnapshot document = expenseDocuments[index];
  //             String category = document["category"];
  //             num amount = document["amount"];

  //             if (category == "Primer" || category == "primer") {
  //               ChartDataModel.hargaPrimer += amount;
  //             } else if (category == "Sekunder" || category == "sekunder") {
  //               hargaSekunder += amount;
  //             } else if (category == "Tersier" || category == "tersier") {
  //               hargaTersier += amount;
  //             } else if (category == "Pendidikan" || category == "pendidikan") {
  //               hargaPendidikan += amount;
  //             }
  //             ChartDataModel.hargaPrimer = 2;
  //             var createAt = document["date"];
  //             var dates = (createAt as Timestamp).toDate();
  //             String name = document["name"];

  //             String itemName = document["itemName"];
  //             String photo = document["photo"];

  //             getTotalByCategory().then((categoryTotal) {
  //               // categoryTotal akan berisi hasil penjumlahan nilai berdasarkan kategori
  //               categoryTotal.forEach((kategori, total) {
  //                 print('$kategori: $total');
  //               });
  //             });
  //           },
  //         );
  //       }
  //     },
  //   ));
  // }

  // static num primer = hargaPrimer;
  // static num sekunder = 0;
  // static num tersier = 0;
  // static num pendidikan = 0;

  static final List<Map<String, dynamic>> chartData = [
    {
      "month": "January",
      "data": {
        "primer": 30000,
        "sekunder": 20000,
        "tersier": 40000,
        "pendidikan": 50000,
      }
    },
    {
      "month": "February",
      "data": {
        "primer": 40000,
        "sekunder": 50000,
        "tersier": 20000,
        "pendidikan": 30000,
      }
    },
    {
      "month": "Maret",
      "data": {
        "primer": 10000,
        "sekunder": 50000,
        "tersier": 40000,
        "pendidikan": 40000,
      }
    },
    {
      "month": "April",
      "data": {
        "primer": 20000,
        "sekunder": 40000,
        "tersier": 55000,
        "pendidikan": 15000,
      }
    },
    {
      "month": "Mei",
      "data": {
        "primer": 40000,
        "sekunder": 40000,
        "tersier": 15000,
        "pendidikan": 5000,
      }
    },
    {
      "month": "Juni",
      "data": {
        "primer": 30000,
        "sekunder": 40000,
        "tersier": 20000,
        "pendidikan": 40000,
      }
    },
    {
      "month": "July",
      "data": {
        "primer": 10000,
        "sekunder": 15000,
        "tersier": 40000,
        "pendidikan": 35000,
      }
    },
    {
      "month": "Agustus",
      "data": {
        "primer": 10000,
        "sekunder": 10000,
        "tersier": 10000,
        "pendidikan": 70000,
      }
    },
    {
      "month": "September",
      "data": {
        "primer": 10000,
        "sekunder": 20000,
        "tersier": 20000,
        "pendidikan": 60000,
      }
    },
    {
      "month": "Oktober",
      "data": {
        "primer": 20000,
        "sekunder": 15000,
        "tersier": 20000,
        "pendidikan": 45000,
      }
    },
    {
      "month": "November",
      "data": {
        "primer": 80000,
        "sekunder": 5000,
        "tersier": 5000,
        "pendidikan": 5000,
      }
    },
    {
      "month": "Desember",
      "data": {
        "primer": 10000,
        "sekunder": 10000,
        "tersier": 70000,
        "pendidikan": 10000,
      }
    },
  ];
}
