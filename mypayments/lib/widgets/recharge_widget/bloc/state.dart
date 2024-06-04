class RechargeState {
  final bool isLoading;
  final String? error;

  RechargeState({required this.isLoading, this.error});

  RechargeState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return RechargeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
