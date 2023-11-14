import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                icon: const Icon(Icons.search_rounded), onPressed: () {}),
            centerTitle: true,
            title: Text("Productos"),
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
