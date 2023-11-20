import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/maps/maps.dart';

class UpdateProducto extends StatefulWidget {
  final String image;
  final String serialNumber;
  final String category;
  final String name;
  final int quantity;
  final double price;
  const UpdateProducto(
      {Key? key,
      required this.image,
      required this.serialNumber,
      required this.category,
      required this.name,
      required this.quantity,
      required this.price})
      : super(key: key);

  @override
  _UpdateProductoState createState() => _UpdateProductoState();
}

class _UpdateProductoState extends State<UpdateProducto> {
  final controllerManager = ControllerManager();

  String? _selectedOption;
  String? categoryId;

  List<String> _categorias = ['Selecciona una categoría'];

  @override
  void initState() {
    super.initState();
    cargarCategoriasDesdeBaseDeDatos();
    obtenerYMostrarCategoryId();
    // Inicializa los controllers con los valores iniciales
    controllerManager.imagePController.text = widget.image;
    controllerManager.numSeriePController.text = widget.serialNumber;
    controllerManager.categoriePController.text = widget.category;
    controllerManager.namePController.text = widget.name;
    controllerManager.cantidadPController.text = widget.quantity.toString();
    controllerManager.pricePController.text = widget.price.toString();
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Actualizando producto"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: CardUpdateProducto(
                      onImageSelected: (imagePath) {
                        controllerManager.imagePController.text = imagePath;
                      },
                      imagePath: controllerManager.imagePController
                          .text, // Pasa la ruta de la imagen a CustomCardAdd
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controllerManager.numSeriePController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              filled: true, labelText: "Num. de serie"),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.barcode_reader),
                            label: Text("Escanea"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF3333FF),
                              ),
                            ),
                          )
                        ],
                      )
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
                    onChanged: (newValue) {
                      setState(() {
                        controllerManager.categoriePController.text = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.00),
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: controllerManager.namePController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(filled: true, labelText: "Nombre"),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controllerManager.cantidadPController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Cantidad",
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: controllerManager.pricePController,
                          keyboardType: TextInputType.number,
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
                  SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
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
                                Text('Producto actualizado con éxito.'),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        );

                        final updatedProduct = ProductsItems(
                          image: controllerManager.imagePController.text,
                          serialNumber:
                              controllerManager.numSeriePController.text,
                          category_id: int.tryParse(controllerManager
                                  .categoriePController.text) ??
                              0,
                          name: controllerManager.namePController.text,
                          quantity: int.tryParse(
                                  controllerManager.cantidadPController.text) ??
                              0,
                          price: double.tryParse(
                                  controllerManager.pricePController.text) ??
                              0.0,
                        );

                        await MyData.instance.updateProductWithId(
                            controllerManager.numSeriePController.text,
                            updatedProduct);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Nav(),
                          ),
                        );
                      },
                      child: Text("Guardar"),
                    ),
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
