import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/screens/home.dart';
import 'package:personal_expense_tracker/screens/profile_screen.dart';
import 'package:personal_expense_tracker/widgets/add_fab.dart';

class BottomNavHolder extends StatefulWidget {
  const BottomNavHolder({Key? key}) : super(key: key);

  @override
  State<BottomNavHolder> createState() => _BottomNavHolderState();
}

class _BottomNavHolderState extends State<BottomNavHolder> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (currentIndex == 1) ? light80 : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const AddFloatingActionButton(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: light80,
        currentIndex: currentIndex,
        selectedFontSize: 12,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: (currentIndex == 0) ? violet100 : null,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(
              "assets/icons/user.svg",
              color: (currentIndex == 1) ? violet100 : null,
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [Home(), ProfileScreen()],
      ),
    );
  }
}
