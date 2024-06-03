class Transaction {
  final DateTime date;
  final double value;

  Transaction({
    required this.date,
    required this.value,
  });

  Transaction copyWith({
    DateTime? date,
    double? value,
  }) {
    return Transaction(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'Transaction(date: $date, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction && other.date == date && other.value == value;
  }

  @override
  int get hashCode => date.hashCode ^ value.hashCode;

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      value: map['value']?.toDouble() ?? 0.0,
    );
  }
}
