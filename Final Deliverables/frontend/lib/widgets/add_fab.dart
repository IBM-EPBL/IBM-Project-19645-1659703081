import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/screens/add_expense.dart';
import 'package:personal_expense_tracker/screens/add_income.dart';

class AddFloatingActionButton extends StatefulWidget {
  const AddFloatingActionButton({Key? key}) : super(key: key);

  @override
  State<AddFloatingActionButton> createState() =>
      _AddFloatingActionButtonState();
}

class _AddFloatingActionButtonState extends State<AddFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: CrossMenuFlowDelegate(_animationController),
      children: [
        RotationTransition(
          turns: Tween(begin: 0.125, end: 0.0).animate(_animationController),
          child: FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: violet100,
            shape: const CircleBorder(),
            onPressed: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            },
            child: SvgPicture.asset("assets/icons/close.svg"),
          ),
        ),
        FloatingActionButton(
          heroTag: UniqueKey(),
          backgroundColor: green100,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddIncomeScreen()));
            _animationController.reverse();
          },
          child: SvgPicture.asset(
            "assets/icons/income.svg",
            color: Colors.white,
          ),
        ),
        FloatingActionButton(
          heroTag: UniqueKey(),
          backgroundColor: red100,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddExpenseScreen()));
            _animationController.reverse();
          },
          child: SvgPicture.asset(
            "assets/icons/expense.svg",
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class CrossMenuFlowDelegate extends FlowDelegate {
  final Animation<double> controller;

  CrossMenuFlowDelegate(this.controller) : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final xStart = (context.size.width / 2) - 28;
    final yStart = context.size.height - 84;
    final dx1 = xStart - 56 * controller.value;
    final dx2 = xStart + 56 * controller.value;
    final dy = yStart - 56 * controller.value;
    context.paintChild(
      2,
      transform: Matrix4.translationValues(
        dx2,
        dy,
        0,
      ),
    );
    context.paintChild(
      1,
      transform: Matrix4.translationValues(
        dx1,
        dy,
        0,
      ),
    );
    context.paintChild(
      0,
      transform: Matrix4.translationValues(
        xStart,
        yStart,
        0,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;
}
