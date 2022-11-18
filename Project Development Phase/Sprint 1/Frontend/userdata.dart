import 'package:isar/isar.dart';

part 'userdata.g.dart';

@collection
class Userdata {
  final Id id = 0;
  final String name;
  final String email;
  final int cycleLength;
  final double budget;
  final DateTime creationDate;
  final String password;

  Userdata(this.name, this.email, this.cycleLength, this.budget,
      this.creationDate, this.password);

  factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(json['name'], json['email'], json['cycleLength'],
        json['budget'], DateTime.parse(json['creationDate']), json['password']);
  }

  Userdata copyWith(
      {String? name,
      String? email,
      int? cycleLength,
      double? budget,
      DateTime? creationDate}) {
    return Userdata(
        name ?? this.name,
        email ?? this.email,
        cycleLength ?? this.cycleLength,
        budget ?? this.budget,
        creationDate ?? this.creationDate,
        password);
  }
}
