import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';

class Categorizacion extends StatefulWidget {
  final String nameCategoria;
  const Categorizacion({Key? key, required this.nameCategoria})
      : super(key: key);

  @override
  _CategorizacionState createState() => _CategorizacionState();
}

class _CategorizacionState extends State<Categorizacion> {
  @override
  Widget build(BuildContext context) {
    final name = widget.nameCategoria;
    print(name);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                icon: const Icon(Icons.search_rounded), onPressed: () {}),
            centerTitle: true,
            title: Text("Categorías"),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_2_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Perfil()),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Color(0xFF9198AB),
                      ),
                    ),
                  ],
                ),
                CustomCardProducto(
                  nombre: 'Llave perico',
                  cantidad: '10',
                  precio: 400.0,
                  direccionImagen: 'assets/llave.jpg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewProductos()),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProducto()),
          );
        },
        child: Icon(
          Icons.add_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
