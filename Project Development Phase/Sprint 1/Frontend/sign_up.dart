import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  final VoidCallback switchScreen;
  const SignUpScreen(
      {Key? key, required this.onBack, required this.switchScreen})
      : super(key: key);

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";
  bool isPasswordObscure = true;
  bool agreedToTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.onBack();
            },
            icon: SvgPicture.asset("assets/icons/arrow_left.svg"),
          ),
          title: const Text("Sign Up"),
        ),
        body: Form(
          key: _formState,
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  cursorColor: light20,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: textInputDecoration.copyWith(hintText: "Name"),
                  validator: (val) =>
                      (val?.isEmpty ?? false) ? "Please enter your name" : null,
                  onChanged: (val) {
                    name = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: light20,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => (val?.isEmpty ?? true)
                      ? "Please enter the email"
                      : !emailValidator.hasMatch(val ?? "")
                          ? "Please enter a valid email"
                          : null,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: light20,
                  obscureText: isPasswordObscure,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (val) => (val?.isEmpty ?? true)
                      ? "Please enter the password"
                      : (val!.length < 6)
                          ? "Password should be at least 6 chars long"
                          : null,
                  decoration: textInputDecoration.copyWith(
                    hintText: "Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          });
                        },
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    password = val;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: agreedToTermsAndConditions,
                      activeColor: violet100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: violet100, width: 2),
                      onChanged: (val) {
                        setState(() {
                          agreedToTermsAndConditions = val ?? false;
                        });
                      },
                    ),
                    Text.rich(
                      TextSpan(
                        text: "By signing up, you agree to the ",
                        children: [
                          TextSpan(
                            text: "Terms of\nService and Privacy Policy",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    "https://www.termsandcondiitionssample.com/"));
                              },
                            style: const TextStyle(
                              color: violet100,
                            ),
                          )
                        ],
                      ),
                      style: body3TextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 27),
                ElevatedButton(
                  onPressed: (agreedToTermsAndConditions)
                      ? () async {
                          if (_formState.currentState!.validate()) {
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
                                        hintText:
                                            "Enter your Cycle Length (in days)",
                                      ),
                                      onChanged: (val) {
                                        cycleLength =
                                            int.tryParse(val) ?? cycleLength;
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
                            int statusCode = await ref
                                .read(authStateProvider.notifier)
                                .signUp(
                                    name, cycleLength, budget, email, password);
                            if (statusCode == 400) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Account Already Exists"),
                                  content: const Text(
                                      "Please login with your existing account"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  child: const Text("Sign Up"),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.switchScreen();
                          },
                        style: const TextStyle(
                          color: violet100,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  style: body1Light20TextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
