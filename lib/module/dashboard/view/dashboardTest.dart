import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hyper_ui/core.dart';

class ExpenseCalculator {
  static Future<Map<String, Map<String, int>>> getTotalExpenseByMonth() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      Map<String, Map<String, int>> monthlyExpenses = {};

      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection("expense")
          .where("user.uid", isEqualTo: currentUserId)
          .get();

      expenseSnapshot.docs.forEach((doc) {
        String category = doc['category'];
        int expenseAmount = doc['amount'];

        // Mendapatkan tanggal pengeluaran
        // Mendapatkan tanggal dari Firestore dalam format string
        String dateString = doc['tanggal'];

// Mengonversi string tanggal menjadi objek DateTime
        DateTime dateTime = DateTime.parse(dateString);

// Menggunakan pustaka intl untuk mengubah nama bulan
        final formattedDate = DateFormat.yMMMM().format(dateTime);

        // Menambahkan pengeluaran ke dalam Map berdasarkan bulan dan kategori
        // Update jumlah pengeluaran untuk kategori dalam bulan tersebut
        if (monthlyExpenses.containsKey(formattedDate)) {
          final categoryData = monthlyExpenses[formattedDate]!;

          if (categoryData.containsKey(category)) {
            categoryData[category] =
                (categoryData[category] ?? 0) + expenseAmount;
          } else {
            categoryData[category] = expenseAmount;
          }
        } else {
          monthlyExpenses[formattedDate] = {category: expenseAmount};
        }
      });

      // Menambahkan jumlah data dari masing-masing kategori dalam setiap bulan
      monthlyExpenses.forEach((formattedDate, categoryData) {
        int totalPerMonth = 0;

        categoryData.forEach((category, amount) {
          totalPerMonth += amount;
        });

        categoryData['Total'] = totalPerMonth;
      });

      return monthlyExpenses;
    } else {
      return {};
    }
  }
}
