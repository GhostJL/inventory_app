import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/llave.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
