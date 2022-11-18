import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/screens/login.dart';
import 'package:personal_expense_tracker/screens/sign_up.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (pageIndex == 3) {
      return SignUpScreen(
        onBack: () {
          setState(() {
            pageIndex = 0;
          });
        },
        switchScreen: () {
          setState(() {
            pageIndex = 4;
          });
        },
      );
    } else if (pageIndex == 4) {
      return LoginScreen(
        onBack: () {
          setState(() {
            pageIndex = 0;
          });
        },
        switchScreen: () {
          setState(() {
            pageIndex = 3;
          });
        },
      );
    }
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (val) {
                  setState(() {
                    pageIndex = val;
                  });
                },
                children: const [
                  OnBoardingPage(
                    assetPath: "assets/onboarding_1.png",
                    title: "Gain total control\n of your money",
                    description:
                        "Become your own money manager\n and make every cent count",
                  ),
                  OnBoardingPage(
                    assetPath: "assets/onboarding_2.png",
                    title: "Know where your\n money goes",
                    description:
                        "Track your transaction easily,\n with categories and financial report ",
                  ),
                  OnBoardingPage(
                    assetPath: "assets/onboarding_3.png",
                    title: "Planning ahead",
                    description:
                        "Setup your budget for a\n specific time period",
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  height: (pageIndex == 0) ? 16 : 8,
                  width: (pageIndex == 0) ? 16 : 8,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: (pageIndex == 0) ? violet100 : violet20,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedContainer(
                  height: (pageIndex == 1) ? 16 : 8,
                  width: (pageIndex == 1) ? 16 : 8,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: (pageIndex == 1) ? violet100 : violet20,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedContainer(
                  height: (pageIndex == 2) ? 16 : 8,
                  width: (pageIndex == 2) ? 16 : 8,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: (pageIndex == 2) ? violet100 : violet20,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pageIndex = 4;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: violet20,
                foregroundColor: violet100,
              ),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final String assetPath;
  final String title;
  final String description;
  const OnBoardingPage(
      {Key? key,
      required this.assetPath,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(assetPath),
        Text(
          title,
          style: title1TextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: body1Light20TextStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
