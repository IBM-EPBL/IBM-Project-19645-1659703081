import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';
import 'package:personal_expense_tracker/screens/bottom_nav_holder.dart';
import 'package:personal_expense_tracker/screens/onboarding.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFuture = ref.watch(authFutureProvider);
    final authState = ref.watch(authStateProvider);
    return authFuture.when(
      loading: () => const Scaffold(
        backgroundColor: violet100,
        body: Center(
          child: Text(
            "Finance\nTracker",
            style: splashLogoTextStyle,
          ),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Center(
          child: Text(
            "Some Unknown Error Occurred\nPlease Try Again Later",
            style: splashLogoTextStyle,
          ),
        ),
      ),
      data: (userData) {
        if (authState != null) {
          return const BottomNavHolder();
        } else {
          return const OnBoardingScreen();
        }
      },
    );
  }
}
