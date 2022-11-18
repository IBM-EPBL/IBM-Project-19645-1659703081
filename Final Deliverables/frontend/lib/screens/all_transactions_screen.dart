import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/controllers/transaction_controller.dart';
import 'package:personal_expense_tracker/widgets/transaction_tile.dart';

class AllTransactionsScreen extends ConsumerWidget {
  const AllTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionList =
        ref.watch(transactionListStateProvider).reversed.toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/icons/arrow_left.svg"),
        ),
        title: const Text("Transactions"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          return TransactionTile(transaction: transactionList[index]);
        },
      ),
    );
  }
}
