import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';

class ViewCategorias extends StatefulWidget {
  final String nameCategoria;
  const ViewCategorias({Key? key, required this.nameCategoria})
      : super(key: key);

  @override
  _ViewCategoriasState createState() => _ViewCategoriasState();
}

class _ViewCategoriasState extends State<ViewCategorias> {
  @override
  Widget build(BuildContext context) {
    final name = widget.nameCategoria;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Categoría"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCategoria(
                          nameCategoria: name,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    int? categoryId =
                        await MyData.instance.getCategoryIdByName(name);
                    print(categoryId);

                    bool? existe = await MyData.instance
                        .verifyCategoryProducts(categoryId!);

                    if (existe!) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('¡Advertencia!'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'No es posible eliminar esta categoría en este momento.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Esta categoría tiene productos asociados. Antes de continuar, por favor realiza una de las siguientes acciones:',
                                ),
                                SizedBox(height: 10),
                                Text(
                                    '• Actualiza la información de los productos.'),
                                Text(
                                    '• Elimina los productos asociados a esta categoría.'),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Entendido'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await MyData.instance.deleteCategory(categoryId);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Nav(),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    initialValue: name,
                    enabled: false,
                    decoration: InputDecoration(
                        filled: true, labelText: "Nombre de la categoria"),
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
