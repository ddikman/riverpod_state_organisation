import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/models/item.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/services/item_repository.dart';
import 'package:riverpod_state_organisation/use_cases/optimistic_failure/state/optimistic_failure_provider.dart';

part 'items_provider.g.dart';

@riverpod
class Items extends _$Items {
  @override
  Future<List<Item>> build() async {
    return ref.watch(itemRepositoryProvider).getItems();
  }

  Future<void> addItem(Item item) async {
    final previousState = state;
    try {
      state = AsyncValue.data([...(previousState.valueOrNull ?? []), item]);
      await ref.watch(itemRepositoryProvider).addItem(item);
    } catch (err) {
      state = previousState;
      ref.read(optimisticFailureProvider.notifier).raise('Failed to add item');
    }
  }

  Future<void> updateItem(Item item) async {
    final previousState = state;
    try {
      state = AsyncValue.data(
        previousState.valueOrNull
                ?.map((e) => e.id == item.id ? item : e)
                .toList() ??
            [],
      );
      await ref.watch(itemRepositoryProvider).updateItem(item);
    } catch (err) {
      state = previousState;
      ref
          .read(optimisticFailureProvider.notifier)
          .raise('Failed to update item');
    }
  }

  Future<void> deleteItem(String id) async {
    final previousState = state;
    try {
      state = AsyncValue.data(
          previousState.valueOrNull?.where((e) => e.id != id).toList() ?? []);
      await ref.watch(itemRepositoryProvider).deleteItem(id);
    } catch (err) {
      state = previousState;
      ref
          .read(optimisticFailureProvider.notifier)
          .raise('Failed to remove item');
    }
  }
}
