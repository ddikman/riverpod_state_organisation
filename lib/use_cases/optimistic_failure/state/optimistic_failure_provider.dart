import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'optimistic_failure_provider.g.dart';

@riverpod
class OptimisticFailure extends _$OptimisticFailure {
  @override
  String? build() {
    return null;
  }

  void raise(String message) {
    state = message;

    // Force a rebuild even if the message is the same
    ref.invalidateSelf();
  }
}
