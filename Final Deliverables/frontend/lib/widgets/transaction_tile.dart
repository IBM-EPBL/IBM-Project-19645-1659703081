import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:personal_expense_tracker/screens/transaction_detail.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconBackgroundColor = yellow20;
    Color iconForegroundColor = yellow100;
    String iconAssetPath = 'assets/icons/shopping.svg';
    String hh = (transaction.transactionDate.hour > 12)
        ? "${transaction.transactionDate.hour - 12}"
        : "${transaction.transactionDate.hour}";
    String mm = transaction.transactionDate.minute < 10
        ? "0${transaction.transactionDate.minute}"
        : "${transaction.transactionDate.minute}";
    String meridiem = transaction.transactionDate.hour > 11 ? "PM" : "AM";
    switch (transaction.category) {
      case Categories.shopping:
        iconBackgroundColor = yellow20;
        iconForegroundColor = yellow100;
        break;
      case Categories.subscription:
        iconBackgroundColor = violet20;
        iconForegroundColor = violet100;
        iconAssetPath = 'assets/icons/subscription.svg';
        break;
      case Categories.food:
        iconBackgroundColor = red20;
        iconForegroundColor = red100;
        iconAssetPath = 'assets/icons/food.svg';
        break;
      case Categories.transport:
        iconBackgroundColor = blue20;
        iconForegroundColor = blue100;
        iconAssetPath = 'assets/icons/transport.svg';
        break;
      case Categories.salary:
        iconBackgroundColor = green20;
        iconForegroundColor = green100;
        iconAssetPath = 'assets/icons/salary.svg';
        break;
      case Categories.passiveIncome:
        iconBackgroundColor = green20;
        iconForegroundColor = green100;
        iconAssetPath = 'assets/icons/subscription.svg';
        break;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionDetailScreen(transaction: transaction)));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        decoration: BoxDecoration(
          color: light80,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(
                iconAssetPath,
                color: iconForegroundColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        transaction.category.toString(),
                        style: body1TextStyle,
                      ),
                      const Spacer(),
                      Text(
                        "${transaction.category.isExpense() ? "-" : "+"}₹${transaction.amount}",
                        style: transaction.category.isExpense()
                            ? body2Red100TextStyle
                            : body2Green100TextStyle,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          transaction.description,
                          style: smallTextStyle,
                        ),
                      ),
                      Text(
                        "$hh:$mm $meridiem",
                        style: smallTextStyle,
                      )
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
