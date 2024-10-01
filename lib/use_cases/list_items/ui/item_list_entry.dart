import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/models/item.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/state/items_provider.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/ui/item_edit_dialog.dart';

class ItemListEntry extends StatelessWidget {
  final Item item;

  const ItemListEntry({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Dismissible(
        key: Key(item.id),
        background: Container(color: Colors.red),
        onDismissed: (direction) =>
            ref.read(itemsProvider.notifier).deleteItem(item.id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            tileColor: Colors.green,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            onTap: () => showDialog(
                barrierColor: Colors.black.withOpacity(0.2),
                barrierDismissible: true,
                context: context,
                builder: (context) =>
                    Center(child: ItemEditDialog(item: item))),
            title: Text(item.name),
            subtitle: Text(item.description),
          ),
        ),
      ),
    );
  }
}
