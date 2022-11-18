import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';
import 'package:personal_expense_tracker/controllers/transaction_controller.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:personal_expense_tracker/screens/all_transactions_screen.dart';
import 'package:personal_expense_tracker/screens/expense_chart.dart';
import 'package:personal_expense_tracker/widgets/transaction_tile.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchTransactionList = ref.watch(fetchTransactionListProvider);
    final transactionList = ref.watch(transactionListStateProvider);
    final userData = ref.watch(authStateProvider);
    return fetchTransactionList.when(
      error: (_, __) => const Center(
        child: Text("Some Unknown Error Occurred"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (_) {
        if (transactionList.isEmpty) {
          return const Center(
            child: Text(
              "No Transaction Added yet",
              style: title2TextStyle,
            ),
          );
        }

        double income = 0;
        double expense = 0;
        double maxY = 1;
        for (int i = 0; i < transactionList.length; i++) {
          if (transactionList[i].category == Categories.salary ||
              transactionList[i].category == Categories.passiveIncome) {
            income += transactionList[i].amount;
          } else {
            expense += transactionList[i].amount;
            if (transactionList[i].amount > maxY) {
              maxY = transactionList[i].amount;
            }
          }
        }
        double balance = userData!.budget - expense;

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF6E5),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text("Amount Left To Spend",
                          style: body3Light20TextStyle),
                      const SizedBox(height: 8),
                      Text("₹ $balance", style: title0TextStyle),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              decoration: BoxDecoration(
                                color: green100,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: light80,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/income.svg"),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Income",
                                        style: body3Light80TextStyle,
                                      ),
                                      Text(
                                        "₹$income",
                                        style: title3Light80TextStyle,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              decoration: BoxDecoration(
                                color: red100,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: light80,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/expense.svg"),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Expenses",
                                        style: body3Light80TextStyle,
                                      ),
                                      Text(
                                        "₹$expense",
                                        style: title3Light80TextStyle,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Text(
                    "Spend Analytics",
                    style: title3dark100TextStyle,
                  ),
                ),
                const ExpenseChart(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Recent Transaction",
                        style: title4TextStyle,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AllTransactionsScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: violet20,
                          foregroundColor: violet100,
                          minimumSize: const Size(78, 32),
                        ),
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (transactionList.length - 1 >= 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TransactionTile(
                      transaction: transactionList[transactionList.length - 1],
                    ),
                  ),
                if (transactionList.length - 2 >= 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TransactionTile(
                      transaction: transactionList[transactionList.length - 2],
                    ),
                  ),
                if (transactionList.length - 3 >= 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TransactionTile(
                      transaction: transactionList[transactionList.length - 3],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
