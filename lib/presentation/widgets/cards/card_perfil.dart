import 'package:flutter/material.dart';

class CardPerfil extends StatelessWidget {
  final String nombre;
  final String direccionImagen;
  final VoidCallback? onTap;

  const CardPerfil({
    Key? key,
    required this.nombre,
    required this.direccionImagen,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withAlpha(30),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          trailing: CircleAvatar(
            backgroundImage: AssetImage(direccionImagen),
          ),
          title: Text(
            "Hola, $nombre",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
