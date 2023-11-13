import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';

class UpdateCategoria extends StatefulWidget {
  const UpdateCategoria({Key? key}) : super(key: key);

  @override
  _UpdateCategoriaState createState() => _UpdateCategoriaState();
}

class _UpdateCategoriaState extends State<UpdateCategoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text("Actualizando categoría"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    initialValue: "Herramientas",
                    decoration: const InputDecoration(
                        filled: true, labelText: "Nombre de la categoría"),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Nav()),
                        );
                      },
                      child: const Text("Guardar"),
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
