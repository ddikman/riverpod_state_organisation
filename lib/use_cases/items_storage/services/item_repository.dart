import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_organisation/use_cases/items_storage/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemRepository {
  static const _itemsKey = 'items';

  bool _attemptWillFail = false;

  final List<Item> _items = [];

  Future<List<Item>> getItems() async {
    await Future.delayed(const Duration(seconds: 2));
    List<dynamic> json =
        jsonDecode(await SharedPreferencesAsync().getString(_itemsKey) ?? '[]');
    return json.map((e) => Item.fromJson(e)).toList();
  }

  Future<void> _storeList() async {
    await SharedPreferencesAsync().setString(
        _itemsKey, jsonEncode(_items.map((e) => e.toJson()).toList()));
  }

  Future<Item> addItem(Item item) async {
    await Future.delayed(const Duration(seconds: 2));
    _triggerFailure();
    _items.add(item);
    await _storeList();
    return item;
  }

  Future<Item> updateItem(Item item) async {
    await Future.delayed(const Duration(seconds: 2));
    _triggerFailure();
    _items.removeWhere((element) => element.id == item.id);
    _items.add(item);
    await _storeList();
    return item;
  }

  Future<void> deleteItem(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    _triggerFailure();
    _items.removeWhere((element) => element.id == id);
    await _storeList();
  }

  void _triggerFailure() {
    try {
      if (_attemptWillFail) {
        throw Exception('Failed to add item');
      }
    } finally {
      _attemptWillFail = !_attemptWillFail;
    }
  }
}

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});
