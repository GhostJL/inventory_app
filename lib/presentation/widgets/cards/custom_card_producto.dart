import 'dart:io';

import 'package:flutter/material.dart';

class CustomCardProducto extends StatelessWidget {
  final String nombre;
  final String cantidad;
  final double precio;
  final String direccionImagen;
  final VoidCallback? onTap;

  const CustomCardProducto({
    Key? key,
    required this.nombre,
    required this.cantidad,
    required this.precio,
    required this.direccionImagen,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.grey.shade50,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(direccionImagen),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3333FF),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Disponibles $cantidad',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF79747E),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      '\$${precio.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3333FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
