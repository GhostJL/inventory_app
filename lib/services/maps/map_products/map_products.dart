class ProductsItems {
  final String image;
  final String serialNumber;
  final int category_id;
  final String name;
  final int quantity;
  final double price;

  ProductsItems(
      {required this.image,
      required this.serialNumber,
      required this.category_id,
      required this.name,
      required this.quantity,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'serialNumber': serialNumber,
      'category_id': category_id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
