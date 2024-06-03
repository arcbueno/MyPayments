class LoginState {
  final bool isLoading;
  final String? error;
  LoginState({
    required this.isLoading,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isLoading': isLoading});
    if (error != null) {
      result.addAll({'error': error});
    }

    return result;
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      isLoading: map['isLoading'] ?? false,
      error: map['error'],
    );
  }

  @override
  String toString() => 'LoginState(isLoading: $isLoading, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ error.hashCode;
}
