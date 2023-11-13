import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';

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
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        onLongPress: onLongPress ?? () {},
        child: Container(
          margin: EdgeInsets.fromLTRB(36, 36, 36, 36),
          child: Text(
            nombre,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF3333FF),
            ),
          ),
        ),
      ),
    );
  }
}
