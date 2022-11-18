import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/transaction_controller.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class ExpenseChart extends ConsumerStatefulWidget {
  const ExpenseChart({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends ConsumerState<ExpenseChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final transactionList = ref.watch(transactionListStateProvider);
    double shoppingAmount = 0;
    double foodAmount = 0;
    double transportAmount = 0;
    double subscriptionAmount = 0;

    for (int i = 0; i < transactionList.length; i++) {
      switch (transactionList[i].category) {
        case Categories.shopping:
          shoppingAmount += transactionList[i].amount;
          break;
        case Categories.subscription:
          subscriptionAmount += transactionList[i].amount;
          break;
        case Categories.food:
          foodAmount += transactionList[i].amount;
          break;
        case Categories.transport:
          transportAmount += transactionList[i].amount;
          break;
      }
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,
          sectionsSpace: 0,
          sections: [
            PieChartSectionData(
              radius: (touchedIndex == 0) ? 110 : 100,
              color: yellow100,
              value: shoppingAmount,
              titleStyle: body3Light80TextStyle,
              showTitle: !(touchedIndex == 0),
              badgeWidget: (touchedIndex == 0)
                  ? const Text(
                      "Shopping",
                      style: body3Light80TextStyle,
                    )
                  : null,
            ),
            PieChartSectionData(
              radius: (touchedIndex == 1) ? 110 : 100,
              color: violet100,
              value: subscriptionAmount,
              titleStyle: body3Light80TextStyle,
              showTitle: !(touchedIndex == 1),
              badgeWidget: (touchedIndex == 1)
                  ? const Text(
                      "Subscription",
                      style: body3Light80TextStyle,
                    )
                  : null,
            ),
            PieChartSectionData(
              radius: (touchedIndex == 2) ? 110 : 100,
              color: red100,
              value: foodAmount,
              titleStyle: body3Light80TextStyle,
              showTitle: !(touchedIndex == 2),
              badgeWidget: (touchedIndex == 2)
                  ? const Text(
                      "Food",
                      style: body3Light80TextStyle,
                    )
                  : null,
            ),
            PieChartSectionData(
              radius: (touchedIndex == 3) ? 110 : 100,
              color: blue100,
              value: transportAmount,
              titleStyle: body3Light80TextStyle,
              showTitle: !(touchedIndex == 3),
              badgeWidget: (touchedIndex == 3)
                  ? const Text(
                      "Transport",
                      style: body3Light80TextStyle,
                    )
                  : null,
            )
          ],
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
        swapAnimationCurve: Curves.easeIn,
      ),
    );
  }
}
