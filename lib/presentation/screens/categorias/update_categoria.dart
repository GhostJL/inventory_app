import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';

class UpdateCategoria extends StatefulWidget {
  final String nameCategoria;
  const UpdateCategoria({Key? key, required this.nameCategoria})
      : super(key: key);

  @override
  _UpdateCategoriaState createState() => _UpdateCategoriaState();
}

class _UpdateCategoriaState extends State<UpdateCategoria> {
  final controllerManager = ControllerManager();
  late final MyData db;

  @override
  void initState() {
    super.initState();
    db = MyData.instance;
  }

  @override
  Widget build(BuildContext context) {
    final oldCategory = widget.nameCategoria;
    controllerManager.newCategory.text = oldCategory;
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
                    controller: controllerManager.newCategory,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        filled: true, labelText: "Nombre de la categoría"),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        int? categoryId = await MyData.instance
                            .getCategoryIdByName(oldCategory);
                        final updated = await db.updateCategory(
                            categoryId!, controllerManager.newCategory.text);
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
