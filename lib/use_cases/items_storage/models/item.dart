class Item {
  final String id;
  final String name;
  final String description;

  Item({required this.id, required this.name, required this.description});

  Item copyWith({String? id, String? name, String? description}) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
}
