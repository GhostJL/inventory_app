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

  Future<void> addProduct(String image, int serialNumber, String category,
      String name, int quantity, double price) async {
    final item = ProductsItems(
        image: image,
        serialNumber: serialNumber,
        category: category,
        name: name,
        quantity: quantity,
        price: price);
    await MyData.instance.insertProducts(item);
  }

  String? _selectedOption = 'Selecciona una familia';
  List<String> list = <String>[
    'Selecciona una familia',
    'Plomeria',
    'Construcción',
    'Herramientas',
    'Refacción',
    'Pisos'
  ];
  @override
  Widget build(BuildContext context) {
    final String image = controllerManager.imagePController.text;
    final int numSerie =
        int.tryParse(controllerManager.numSeriePController.text) ?? 0;
    final String categoria = controllerManager.categoriePController.text;
    final String nombre = controllerManager.namePController.text;
    final int cantidad =
        int.tryParse(controllerManager.cantidadPController.text) ?? 0;
    final double precio =
        double.tryParse(controllerManager.pricePController.text) ?? 0.00;

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
                      controllerManager.imagePController.text = imagePath;
                      debugPrint('Ruta de la imagen: $imagePath');
                    },
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controllerManager.codeController,
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
                                    controllerManager.codeController.text = res;
                                    print(
                                        "Codigo ${controllerManager.codeController.text}");
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
                    items: list.map((option) {
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
                      onPressed: () {
                        addProduct(image, numSerie, categoria, nombre, cantidad,
                            precio);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            content: Text('Producto registrado'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Nav()),
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
