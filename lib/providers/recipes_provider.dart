import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipebook/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  Future<void> fetchRecipes() async {
    // Puerto para Android: 10.0.2.2
    // Puerto para iOS: 127.0.0.1
    // Puerto para Web: localhost
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('http://192.168.100.106:7701/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
          data['recipes'].map((recipe) => Recipe.fromJSON(recipe)),
        );
      } else {
        print('Error ${response.statusCode}');
        recipes = [];
      }
    } catch (e) {
      print('Request error');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
