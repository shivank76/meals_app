import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});
  @override
  State<TabBarScreen> createState() {
    return _TabBarScreenState();
  }
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndexPage = 0;
  final List<Meal> _favouriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleFavouriteMealStatus(Meal meal) {
    bool isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showMessage('Removed from the favourites :(');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showMessage('Added to the favourites :)');
    }
  }

  void _selectScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen =
        CategoryScreen(onToggleFavouriteMealStatus: _toggleFavouriteMealStatus);
    String activeScreenTitle = 'Categories';
    if (_selectedIndexPage == 1) {
      activeScreen = MealsScreen(
          meals: _favouriteMeals,
          onToggleFavouriteMealStatus: _toggleFavouriteMealStatus);
      activeScreenTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndexPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
        ],
      ),
    );
  }
}
