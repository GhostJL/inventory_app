import 'dart:io';

import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String image;
  const CardView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          File(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
