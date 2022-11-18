import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/transaction_controller.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final Transaction transaction;
  const TransactionDetailScreen({Key? key, required this.transaction})
      : super(key: key);

  String weekDayString(int weekDay) {
    switch (weekDay) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return weekDay.toString();
    }
  }

  String monthString(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return month.toString();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color scaffoldBackgroundColor = yellow100;
    switch (transaction.category) {
      case Categories.shopping:
        scaffoldBackgroundColor = yellow100;
        break;
      case Categories.subscription:
        scaffoldBackgroundColor = violet100;
        break;
      case Categories.food:
        scaffoldBackgroundColor = red100;
        break;
      case Categories.transport:
        scaffoldBackgroundColor = blue100;
        break;
      case Categories.salary:
        scaffoldBackgroundColor = green100;
        break;
      case Categories.passiveIncome:
        scaffoldBackgroundColor = green100;
        break;
    }
    String hh = (transaction.transactionDate.hour > 12)
        ? "${transaction.transactionDate.hour - 12}"
        : "${transaction.transactionDate.hour}";
    String mm = transaction.transactionDate.minute < 10
        ? "0${transaction.transactionDate.minute}"
        : "${transaction.transactionDate.minute}";
    String meridiem = transaction.transactionDate.hour > 11 ? "PM" : "AM";

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/arrow_left.svg",
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: violet40,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Remove this transaction?",
                        style: title3dark100TextStyle,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Are you sure do you wanna remove this transaction?",
                        style: body1Light20TextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: violet20,
                                foregroundColor: violet100,
                              ),
                              child: const Text("No"),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(transactionListStateProvider.notifier)
                                    .deleteTransaction(transaction.tId);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(),
                              child: const Text("Yes"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: SvgPicture.asset("assets/icons/trash.svg"),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "₹${transaction.amount}",
              style: amountTextStyle,
            ),
            Text(
              transaction.description,
              style: title3Light80TextStyle,
            ),
            const SizedBox(height: 8),
            Text(
              "${weekDayString(transaction.transactionDate.weekday)} ${transaction.transactionDate.day} ${monthString(transaction.transactionDate.month)} ${transaction.transactionDate.year}    $hh:$mm $meridiem",
              style: body3Light80TextStyle,
            ),
            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Type",
                        style: body3Light20TextStyle,
                      ),
                      Text(
                        transaction.category.isExpense() ? "Expense" : "Income",
                        style: body2Dark100TextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text(
                        "Category",
                        style: body3Light20TextStyle,
                      ),
                      Text(
                        transaction.category.toString(),
                        style: body2Dark100TextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
