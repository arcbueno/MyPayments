class AddContactState {
  final bool isLoading;
  final String? error;
  AddContactState({
    required this.isLoading,
    this.error,
  });

  AddContactState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AddContactState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
