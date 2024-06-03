import 'package:flutter/foundation.dart';

import 'package:mypayments/models/transaction.dart';

class Contact {
  final int id;
  final String name;
  final String number;
  final List<Transaction> history;

  Contact({
    required this.id,
    required this.name,
    required this.history,
    required this.number,
  });

  Contact copyWith({
    int? id,
    String? name,
    List<Transaction>? history,
    String? number,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      history: history ?? this.history,
      number: number ?? this.number,
    );
  }

  @override
  String toString() =>
      'Contact(id: $id, name: $name, history: $history, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.id == id &&
        other.name == name &&
        listEquals(other.history, history) &&
        other.number == number;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ history.hashCode ^ number.hashCode;

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      history: List<Transaction>.from(
          map['history']?.map((x) => Transaction.fromMap(x))),
      number: map['number'] ?? '',
    );
  }
}
