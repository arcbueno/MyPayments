import 'package:flutter/foundation.dart';

import 'package:mypayments/models/transaction.dart';

class Contact {
  final String name;
  final String number;
  final List<Transaction> history;

  Contact({
    required this.name,
    required this.history,
    required this.number,
  });

  Contact copyWith({
    String? name,
    List<Transaction>? history,
    String? number,
  }) {
    return Contact(
      name: name ?? this.name,
      history: history ?? this.history,
      number: number ?? this.number,
    );
  }

  @override
  String toString() =>
      'Contact(name: $name, history: $history, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.name == name &&
        listEquals(other.history, history) &&
        other.number == number;
  }

  @override
  int get hashCode => name.hashCode ^ history.hashCode ^ number.hashCode;

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] ?? '',
      history: List<Transaction>.from(
          map['history']?.map((x) => Transaction.fromMap(x))),
      number: map['number'] ?? '',
    );
  }
}
