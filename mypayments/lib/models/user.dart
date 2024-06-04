import 'package:flutter/foundation.dart';

import 'package:mypayments/models/contact.dart';

class User {
  final String id;
  final String name;
  final String email;
  final List<Contact> contacts;
  final double balance;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.contacts,
    required this.balance,
    required this.isVerified,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<Contact>? contacts,
    double? balance,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      contacts: contacts ?? this.contacts,
      balance: balance ?? this.balance,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, contacts: $contacts, balance: $balance, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        listEquals(other.contacts, contacts) &&
        other.balance == balance &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        contacts.hashCode ^
        balance.hashCode ^
        isVerified.hashCode;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      contacts:
          List<Contact>.from(map['contacts']?.map((x) => Contact.fromMap(x))),
      balance: map['balance']?.toDouble() ?? 0.0,
      isVerified: map['isVerified'] ?? false,
    );
  }
}
