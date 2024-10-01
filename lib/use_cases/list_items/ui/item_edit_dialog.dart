import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/models/item.dart';
import 'package:riverpod_state_organisation/use_cases/list_items/state/items_provider.dart';

class ItemEditDialog extends StatefulWidget {
  final Item item;

  const ItemEditDialog({super.key, required this.item});

  @override
  State<ItemEditDialog> createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Edit item'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'))),
                    const SizedBox(width: 16),
                    Expanded(child: Consumer(builder: (context, ref, child) {
                      return ElevatedButton(
                          onPressed: () => _updateItem(context, ref),
                          child: const Text('Save'));
                    })),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  _updateItem(BuildContext context, WidgetRef ref) async {
    final item = widget.item.copyWith(name: nameController.text);
    ref.read(itemsProvider.notifier).updateItem(item);
    Navigator.of(context).pop();
  }
}
