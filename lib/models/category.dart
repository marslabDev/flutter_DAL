class Category {
  String? id;
  String name = '';
  String? description;
  String? photo;

  Category({
    this.id,
    required this.name,
    this.description,
    this.photo,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString(),
      name: json['name'],
      description: json['description'],
      photo: json['photo'],
    );
  }

  static List<Category> listfromJSON(dynamic list) {
    return List<Category>.from(
      list.map((json) => Category.fromJSON(json)),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
    };
  }
}
