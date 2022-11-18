import 'dart:convert';

List<Transaction> transactionListFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

class Transaction {
  final int tId;
  final double amount;
  final Categories category;
  final String description;
  final DateTime transactionDate;

  Transaction(
    this.tId,
    this.amount,
    this.category,
    this.description,
    this.transactionDate,
  );

  factory Transaction.fromJson(Map<String, dynamic> json) {
    Categories fetchedCategory;
    switch (json["category"]) {
      case 'Shopping':
        fetchedCategory = Categories.shopping;
        break;
      case 'Subscription':
        fetchedCategory = Categories.subscription;
        break;
      case 'Food':
        fetchedCategory = Categories.food;
        break;
      case 'Transport':
        fetchedCategory = Categories.transport;
        break;
      case 'Salary':
        fetchedCategory = Categories.salary;
        break;
      case 'Passive Income':
        fetchedCategory = Categories.passiveIncome;
        break;
      default:
        fetchedCategory = Categories.shopping;
    }
    return Transaction(
      json["tId"],
      json["amount"],
      fetchedCategory,
      json["description"],
      DateTime.parse(json["transactionDate"]),
    );
  }
}

enum Categories {
  shopping,
  subscription,
  food,
  transport,
  salary,
  passiveIncome;

  @override
  String toString() {
    switch (this) {
      case Categories.shopping:
        return "Shopping";
      case Categories.subscription:
        return "Subscription";
      case Categories.food:
        return "Food";
      case Categories.transport:
        return "Transport";
      case Categories.salary:
        return "Salary";
      case Categories.passiveIncome:
        return "Passive Income";
    }
  }

  bool isExpense() {
    if (this == Categories.salary || this == Categories.passiveIncome) {
      return false;
    } else {
      return true;
    }
  }
}
