import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/maps/maps.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddProducto extends StatefulWidget {
  const AddProducto({Key? key}) : super(key: key);

  @override
  _AddProductoState createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {
  final controllerManager = ControllerManager();

  String? _selectedOption;
  List<String> _categorias = ['Selecciona una categoría'];
  @override
  void initState() {
    super.initState();
    cargarCategoriasDesdeBaseDeDatos();
    controllerManager.categoriePController.text = 'Selecciona una categoría';
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

  Future<void> addProduct(String image, String serialNumber, int category_id,
      String name, int quantity, double price) async {
    final item = ProductsItems(
        image: image,
        serialNumber: serialNumber,
        category_id: category_id,
        name: name,
        quantity: quantity,
        price: price);
    await MyData.instance.insertProducts(item);
  }

  @override
  Widget build(BuildContext context) {
    print(controllerManager.categoriePController.text);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Agregando producto"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  CustomCardAdd(
                    onImageSelected: (imagePath) {
                      print('onImageSelected: $imagePath');
                      String defaultImagePath = 'assets/default.jpg';
                      controllerManager.imagePController.text =
                          imagePath ?? defaultImagePath;
                      print(
                          'imagePController: ${controllerManager.imagePController.text}');
                    },
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
                            onPressed: () async {
                              var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SimpleBarcodeScannerPage(),
                                ),
                              );
                              setState(
                                () {
                                  if (res is String) {
                                    controllerManager.numSeriePController.text =
                                        res;
                                  }
                                },
                              );
                            },
                            icon: Icon(Icons.barcode_reader),
                            label: Text("Escanea"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF3333FF),
                              ),
                            ),
                          ),
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
                        if (controllerManager.categoriePController.text ==
                            'Selecciona una categoría') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  '¡Ups!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text(
                                    'Por favor, selecciona una opción válida antes de continuar.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          int? categoryId = await MyData.instance
                              .getCategoryIdByName(
                                  controllerManager.categoriePController.text);
                          print(categoryId);
                          addProduct(
                            controllerManager.imagePController.text,
                            controllerManager.numSeriePController.text,
                            categoryId!,
                            controllerManager.namePController.text,
                            int.tryParse(controllerManager
                                    .cantidadPController.text) ??
                                0,
                            double.tryParse(
                                    controllerManager.pricePController.text) ??
                                0.0,
                          );
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
                                  Text('Producto agregado con éxito.'),
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
                        }
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
