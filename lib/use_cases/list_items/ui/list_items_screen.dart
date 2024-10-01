import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/models/item.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/state/items_provider.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/ui/item_list_entry.dart';
import 'package:uuid/uuid.dart';

class ListItemsScreen extends ConsumerWidget {
  const ListItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Items'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(ref),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      body: Center(
        // The future provider will provide the new value, when it has it
        // so it will not actually rebuild the UI with a loader the 2nd time
        // As per the [docs](https://riverpod.dev/docs/providers/future_provider)
        // FutureProvider gains a lot when combined with ref.watch.
        // This combination allows automatic re-fetching of some data when some
        // variables change, ensuring that we always have the most up-to-date value.
        child: ref.watch(itemsProvider).when(
              data: (items) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total ${items.length} items'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ItemListEntry(item: items[index]);
                      },
                    ),
                  ),
                ],
              ),
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }

  _addItem(WidgetRef ref) {
    final item = Item(
      id: const Uuid().v4(),
      name: 'Item ${DateTime.now().millisecondsSinceEpoch}',
      description: 'Description',
    );
    ref.read(itemsProvider.notifier).addItem(item);
    debugPrint('Added item ${item.id}');
  }
}
