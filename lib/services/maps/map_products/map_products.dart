class ProductsItems {
  final String image;
  final int serialNumber;
  final String category;
  final String name;
  final int quantity;
  final double price;

  ProductsItems(
      {required this.image,
      required this.serialNumber,
      required this.category,
      required this.name,
      required this.quantity,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'serialNumber': serialNumber,
      'category': category,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
