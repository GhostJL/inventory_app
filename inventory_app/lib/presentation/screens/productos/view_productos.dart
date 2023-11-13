import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';

class ViewProductos extends StatefulWidget {
  const ViewProductos({Key? key}) : super(key: key);

  @override
  _ViewProductosState createState() => _ViewProductosState();
}

class _ViewProductosState extends State<ViewProductos> {
  String? _selectedOption = 'Herramientas';
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
                      MaterialPageRoute(builder: (context) => UpdateProducto()),
                    );
                  },
                  icon: Icon(Icons.edit_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: CardView()),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          initialValue: "123456789",
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
                    onChanged: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.00),
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    initialValue: "Llave perico",
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
                          initialValue: "10",
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
                          initialValue: "400",
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
