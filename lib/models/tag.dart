class Tag {
  String? id;
  String name = '';

  Tag({
    this.id,
    required this.name,
  });

  factory Tag.fromJSON(Map<String, dynamic> json) {
    return Tag(
      id: json['id']?.toString(),
      name: json['name'],
    );
  }

  static List<Tag> listFromJSON(dynamic list) {
    return List<Tag>.from(
      list.map((json) {
        return Tag.fromJSON(json);
      }),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
    };
  }
}
