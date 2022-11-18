import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:personal_expense_tracker/models/userdata.dart';

final authFutureProvider = FutureProvider<Userdata?>((ref) async {
  int statusCode = await ref.read(authStateProvider.notifier).initAuthState();
  final userData = ref.read(authStateProvider);
  if (statusCode == 200 || userData != null) {
    return userData;
  } else {
    return null;
  }
});
final authStateProvider =
    StateNotifierProvider<AuthState, Userdata?>((ref) => AuthState(null));

class AuthState extends StateNotifier<Userdata?> {
  late final Isar isar;
  AuthState(super.state);

  Future<int> initAuthState() async {
    isar = await Isar.open([UserdataSchema]);
    final cachedUserData = await isar.userdatas.get(0);
    if (cachedUserData != null) {
      return await login(cachedUserData.email, cachedUserData.password);
    }
    return -1;
  }

  Future<int> signUp(String name, int cycleLength, double budget, String email,
      String password) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/register/"),
      body: {
        'name': name,
        'cycleLength': cycleLength.toString(),
        'budget': budget.toString(),
        'email': email,
        'password': password
      },
    );
    if (response.statusCode == 200) {
      state = Userdata.fromJson(jsonDecode(response.body));
      await isar.writeTxn(() async {
        await isar.userdatas.put(state!);
      });
    }
    return response.statusCode;
  }

  Future<int> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/login/"),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      state = Userdata.fromJson(jsonDecode(response.body));
      await isar.writeTxn(() async {
        await isar.userdatas.put(state!);
      });
    }
    return response.statusCode;
  }

  Future logout() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:5000/logout/"),
    );
    if (response.statusCode == 200) {
      state = null;
      await isar.writeTxn(() async {
        await isar.userdatas.delete(0);
      });
    }
  }

  Future updateBudget(int cycleLength, double budget) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/updateBudget/"),
      body: {
        'cycleLength': cycleLength.toString(),
        'budget': budget.toString(),
        'email': state?.email
      },
    );
    if (response.statusCode == 200) {
      state = state?.copyWith(cycleLength: cycleLength, budget: budget);
    }
  }
}

//TODO: Edit url when deployed
