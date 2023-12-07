import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void manipulateOnMeal(Meal meal, bool isFavorite) {
    bool isMealExistOnFavorites = _favouriteMeals.contains(meal);
    if (isFavorite) {
      if (!isMealExistOnFavorites) _favouriteMeals.add(meal);
    } else {
      if (isMealExistOnFavorites) _favouriteMeals.remove(meal);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = const MealsScreen(meals: []);
      activePageTitle = 'a Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: ('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: ('Favorites'),
          ),
        ],
      ),
    );
  }
}
