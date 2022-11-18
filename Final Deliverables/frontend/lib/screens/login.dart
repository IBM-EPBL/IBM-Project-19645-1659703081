import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  final VoidCallback switchScreen;
  const LoginScreen(
      {Key? key, required this.onBack, required this.switchScreen})
      : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isPasswordObscure = true;

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
          title: const Text("Login"),
        ),
        body: Form(
          key: _formState,
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: [
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
                  validator: (val) => (val?.isEmpty ?? true)
                      ? "Please enter the password"
                      : (val!.length < 6)
                          ? "Password should be at least 6 chars long"
                          : null,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formState.currentState!.validate()) {
                      int statusCode = await ref
                          .read(authStateProvider.notifier)
                          .login(email, password);
                      if (statusCode == 400) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Invalid Credentials"),
                            content: const Text(
                                "Please check your email and password again"),
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
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: "Don’t have an account yet? ",
                    children: [
                      TextSpan(
                        text: "Sign Up",
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
