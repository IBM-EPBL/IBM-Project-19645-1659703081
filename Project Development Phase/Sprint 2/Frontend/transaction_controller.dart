import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:http/http.dart' as http;

final fetchTransactionListProvider = FutureProvider((ref) async {
  await ref.watch(transactionListStateProvider.notifier).fetchTransactions();
});

final transactionListStateProvider =
    StateNotifierProvider<TransactionListState, List<Transaction>>(
        (ref) => TransactionListState(ref));

class TransactionListState extends StateNotifier<List<Transaction>> {
  StateNotifierProviderRef ref;
  TransactionListState(this.ref, [List<Transaction>? initialTransactions])
      : super(initialTransactions ?? []);

  Future fetchTransactions() async {
    final response = await http.get(
      Uri.parse(
          "http://10.0.2.2:5000/transaction/${ref.read(authStateProvider)?.email}/listAll/"),
    );
    if (response.statusCode == 200) {
      state = transactionListFromJson(response.body);
    }
  }

  Future addTransaction(
      double amount, Categories category, String description) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/transaction/add/"),
      body: {
        'amount': amount.toString(),
        'category': category.toString(),
        'description': description,
        'email': ref.read(authStateProvider)?.email,
      },
    );
    if (response.statusCode == 200) {
      state = [...state, Transaction.fromJson(jsonDecode(response.body))];
    }
  }

  Future deleteTransaction(int tId) async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:5000/transaction/delete/$tId"),
    );
    if (response.statusCode == 200) {
      state = state.where((transaction) => transaction.tId != tId).toList();
    }
  }
}
