import 'package:flutter/material.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/ui/list_items_screen.dart';
import 'package:riverpod_state_organisation/use_cases/optimistic_failure/ui/failure_dialog_wrapper.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FailureDialogWrapper(child: ListItemsScreen()));
  }
}
