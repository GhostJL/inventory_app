import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddProducto extends StatefulWidget {
  const AddProducto({Key? key}) : super(key: key);

  @override
  _AddProductoState createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {
  final controllerManager = ControllerManager();
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
    final barcodeController = controllerManager.codeController;
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
                      debugPrint('Ruta de la imagen: $imagePath');
                    },
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: barcodeController,
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
                                    barcodeController.text = res;
                                    print("Codigo ${barcodeController.text}");
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
                        _selectedOption = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.00),
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
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
