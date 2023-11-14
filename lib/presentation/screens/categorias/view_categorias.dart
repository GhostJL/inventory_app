import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';

class ViewCategorias extends StatefulWidget {
  const ViewCategorias({Key? key}) : super(key: key);

  @override
  _ViewCategoriasState createState() => _ViewCategoriasState();
}

class _ViewCategoriasState extends State<ViewCategorias> {
  @override
  Widget build(BuildContext context) {
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
                          builder: (context) => UpdateCategoria()),
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
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
                    initialValue: "Herramientas",
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
