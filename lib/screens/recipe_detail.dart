import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeName;
  const RecipeDetail({
    super.key,
    required this.recipeName /* Se necesita pasar al constructor */,
  }); // Se agrega el this ya que estamos hablando de la variable misma que creamos, es decir, RecipeDetal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ), // Ayuda a regresar a la página anterior
      ),
    );
  }
}
