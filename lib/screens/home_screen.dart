import 'package:flutter/material.dart';
import 'package:recipebook/screens/recipe_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_RecipesCard(context), _RecipesCard(context)],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  //Función para el modal

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que el modal ocupe más espacio
      builder: (contexto) => Padding(
        padding: EdgeInsets.only(
          //Ajusta la altura considerando el teclado
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width, //Ajusta el padding
          height: 500,
          color: Colors.white,
          child: const RecipeForm(),
        ),
      ),
    );
  }
}

Widget _RecipesCard(BuildContext context) {
  return GestureDetector(
    // Redirige desde el home al detalle de la receta
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (
                context,
              ) /* Permite hacer el traspaso de Navigator.push a RecipeDetail */ =>
                  RecipeDetail(recipeName: 'Lasagna'),
        ),
      ); // Al dar click en la card de la receta redirige al detalle
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                child: ClipRRect(
                  child: Image.network(
                    'https://static.platzi.com/media/uploads/flutter_lasana_b894f1aee1.jpg',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lasagna',
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: 4),
                  Container(height: 2, width: 75, color: Colors.orange),
                  Text(
                    'J. Nila',
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeIMG = TextEditingController();
    final TextEditingController _recipeDescription = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'A new recipe',
              style: TextStyle(color: Colors.orange, fontSize: 24),
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _recipeName,
              label: 'Recipe Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce the recipes Name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _recipeAuthor,
              label: 'Author',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce the Author';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _recipeIMG,
              label: 'Image URL',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce the Image URL';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              maxLines: 4,
              controller: _recipeDescription,
              label: 'Recipe',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introduce the recipes description';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand', color: Colors.orange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
