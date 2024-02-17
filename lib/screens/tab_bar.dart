import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});
  @override
  State<TabBarScreen> createState() {
    return _TabBarScreenState();
  }
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndexPage = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const CategoryScreen();
    String activeScreenTitle = 'Categories';
    if (_selectedIndexPage == 1) {
      activeScreen = const MealsScreen(title: 'Favourites', meals: []);
      activeScreenTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndexPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
