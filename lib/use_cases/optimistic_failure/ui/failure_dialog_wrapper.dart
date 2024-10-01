import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_organisation/use_cases/optimistic_failure/state/optimistic_failure_provider.dart';

class FailureDialogWrapper extends ConsumerWidget {
  final Widget child;

  const FailureDialogWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(optimisticFailureProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next)));
      }
    });

    return child;
  }
}
