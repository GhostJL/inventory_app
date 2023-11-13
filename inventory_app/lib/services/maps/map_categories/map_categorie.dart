class CategoriesItem {
  final String name;

  CategoriesItem({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
