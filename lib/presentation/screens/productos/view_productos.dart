import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/maps/maps.dart';

class ViewProductos extends StatefulWidget {
  final String image;
  final String serialNumber;
  final String category;
  final String name;
  final int quantity;
  final double price;

  const ViewProductos(
      {Key? key,
      required this.image,
      required this.serialNumber,
      required this.category,
      required this.name,
      required this.quantity,
      required this.price})
      : super(key: key);

  @override
  _ViewProductosState createState() => _ViewProductosState();
}

class _ViewProductosState extends State<ViewProductos> {
  final controllerManager = ControllerManager();
  String? _selectedOption;
  String? categoryId;

  List<String> _categorias = ['Selecciona una categoría'];

  @override
  void initState() {
    super.initState();
    cargarCategoriasDesdeBaseDeDatos();
    obtenerYMostrarCategoryId();
  }

  Future<void> cargarCategoriasDesdeBaseDeDatos() {
    return MyData.instance
        .getAllItemsCat()
        .then((List<CategoriesItem> categoriasLista) {
      List<String> nombresCategorias =
          categoriasLista.map((categoria) => categoria.name).toList();

      setState(() {
        _categorias.addAll(nombresCategorias);
        if (_categorias.isNotEmpty) {
          _selectedOption = _categorias[0];
        } else {
          print("No se obtuvieron las categorias");
        }
      });
    }).catchError((error) {
      print('Error al cargar categorías: $error');
    });
  }

  Future<void> obtenerYMostrarCategoryId() async {
    String categoryIdToSearch = widget.category;

    categoryId = await MyData.instance.getCategoryNameById(categoryIdToSearch);

    print("Cate de Prod $categoryId");

    setState(() {
      _selectedOption = categoryId ?? 'Selecciona una categoría';
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    final serialNumber = widget.serialNumber;
    final category = widget.category;
    final name = widget.name;
    final quantity = widget.quantity;
    final price = widget.price;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Producto"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProducto(
                          image: image,
                          serialNumber: serialNumber,
                          category: category,
                          name: name,
                          quantity: quantity,
                          price: price,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () async {
                    int? productId =
                        await MyData.instance.getProductIdByName(name);
                    print(productId);
                    await MyData.instance.deleteProducts(productId!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8.0),
                            Text('Producto eliminado con éxito.'),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Nav(),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: CardView(
                        image: image,
                      )),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          initialValue: serialNumber,
                          enabled: false,
                          decoration: InputDecoration(
                              filled: true, labelText: "Num. de serie"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  DropdownButtonFormField<String>(
                    value: _selectedOption,
                    items: _categorias.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyle(
                            color: Color(0xFF9198AB),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.00),
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    initialValue: name,
                    enabled: false,
                    decoration:
                        InputDecoration(filled: true, labelText: "Nombre"),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          initialValue: quantity.toString(),
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Cantidad",
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: price.toString(),
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Precio",
                            hintText: "M.X.N",
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
