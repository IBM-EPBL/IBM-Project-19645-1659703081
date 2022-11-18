import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Welcome",
            style: body3Light20TextStyle,
          ),
          Text(
            authState?.name ?? "User",
            style: title2TextStyle,
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () async {
              int cycleLength = 30;
              double budget = 30000;
              await showModalBottomSheet(
                context: context,
                isDismissible: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: light20,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Enter your Cycle Length (in days)",
                        ),
                        onChanged: (val) {
                          cycleLength = int.tryParse(val) ?? cycleLength;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: light20,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Enter your budget amount",
                        ),
                        onChanged: (val) {
                          budget = double.tryParse(val) ?? budget;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                ),
              );
              await ref
                  .read(authStateProvider.notifier)
                  .updateBudget(cycleLength, budget);
            },
            child: Container(
              height: 89,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: violet20,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SvgPicture.asset("assets/icons/wallet.svg"),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Change Budget",
                    style: body1TextStyle,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Colors.black.withOpacity(0.4),
          ),
          GestureDetector(
            onTap: () {
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
                        "Logout?",
                        style: title3dark100TextStyle,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Are you sure do you want to logout?",
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
                                ref.read(authStateProvider.notifier).logout();
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
            child: Container(
              height: 89,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: red20,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SvgPicture.asset("assets/icons/logout.svg"),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Logout",
                    style: body1TextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
