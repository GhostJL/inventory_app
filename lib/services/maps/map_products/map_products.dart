class ProdutsItems {
  final String image;
  final int numSerie;
  final String categoria;
  final String nombre;
  final int cantidad;
  final double precio;

  ProdutsItems(
      {required this.image,
      required this.numSerie,
      required this.categoria,
      required this.nombre,
      required this.cantidad,
      required this.precio});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'numSerie': numSerie,
      'categoria': categoria,
      'nombre': nombre,
      'cantidad': cantidad,
      'precio': precio,
    };
  }
}
