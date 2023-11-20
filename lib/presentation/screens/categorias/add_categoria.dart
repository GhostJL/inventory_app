import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/maps/maps.dart';

class AddCategoria extends StatefulWidget {
  const AddCategoria({Key? key}) : super(key: key);

  @override
  _AddCategoriaState createState() => _AddCategoriaState();
}

class _AddCategoriaState extends State<AddCategoria> {
  final controllerManager = ControllerManager();

  Future<void> addCategorie(String name) async {
    final item = CategoriesItem(name: name);
    await MyData.instance.insertCategorie(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Agregando categoría"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerManager.categorieController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        filled: true, labelText: "Nombre de la categoria"),
                  ),
                  SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        addCategorie(
                            controllerManager.categorieController.text);
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
                                Text('Categoría agregada con éxito.'),
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
