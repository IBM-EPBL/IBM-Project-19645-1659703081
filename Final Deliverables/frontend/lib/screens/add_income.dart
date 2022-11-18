import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_expense_tracker/constants.dart';
import 'package:personal_expense_tracker/controllers/transaction_controller.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class AddIncomeScreen extends ConsumerStatefulWidget {
  const AddIncomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends ConsumerState<AddIncomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController amountTextEditingController =
      TextEditingController(text: "0");
  Categories selectedCategory = Categories.salary;
  String description = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: green100,
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
          title: const Text(
            "Income",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "How Much?",
                  style: title3TextStyle.copyWith(
                    color: light80.withOpacity(0.64),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  controller: amountTextEditingController,
                  style: moneyInputTextStyle,
                  decoration: moneyTextInputDecoration,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    if (val.startsWith("0")) {
                      amountTextEditingController.text =
                          "${int.tryParse(val) ?? "0"}";
                      amountTextEditingController.selection =
                          TextSelection.collapsed(
                              offset: amountTextEditingController.text.length);
                    }
                  },
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<Categories>(
                          value: selectedCategory,
                          decoration: textInputDecoration.copyWith(
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 20, 12, 16),
                          ),
                          isExpanded: true,
                          icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                          items: const [
                            DropdownMenuItem(
                              value: Categories.salary,
                              child: Text("Salary"),
                            ),
                            DropdownMenuItem(
                              value: Categories.passiveIncome,
                              child: Text("Passive Income"),
                            ),
                          ],
                          onChanged: (val) {
                            selectedCategory = val ?? selectedCategory;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: light20,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Description",
                        ),
                        validator: (val) => (val?.isEmpty ?? false)
                            ? "Please enter a description"
                            : null,
                        onChanged: (val) {
                          description = val;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(transactionListStateProvider.notifier)
                                .addTransaction(
                                    double.parse(
                                        amountTextEditingController.text),
                                    selectedCategory,
                                    description);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
