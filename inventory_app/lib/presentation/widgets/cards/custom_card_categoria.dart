import 'package:flutter/material.dart';

class CustomCardCategoria extends StatelessWidget {
  final String nombre;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CustomCardCategoria({
    Key? key,
    required this.nombre,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.grey.shade50,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        onLongPress: onLongPress ?? () {},
        child: Container(
          margin: EdgeInsets.fromLTRB(36, 36, 36, 36),
          child: Center(
            child: Text(
              nombre,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3333FF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListaDeCustomCardCategoria extends StatefulWidget {
  final List<String> categoryNames;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  ListaDeCustomCardCategoria({
    required this.categoryNames,
    this.onTap,
    this.onLongPress,
  });

  @override
  _ListaDeCustomCardCategoriaState createState() =>
      _ListaDeCustomCardCategoriaState();
}

class _ListaDeCustomCardCategoriaState
    extends State<ListaDeCustomCardCategoria> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: widget.categoryNames.length,
      itemBuilder: (context, index) {
        return CustomCardCategoria(
          nombre: widget.categoryNames[index],
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        );
      },
    );
  }
}
