import 'package:flutter/material.dart';
import 'package:play_app/models/meal.dart';
import 'package:play_app/screens/categories.dart';
import 'package:play_app/screens/filters.dart';
import 'package:play_app/screens/meals.dart';
import 'package:play_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favoriteMeals = [];

  void _toggleFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        showInfoMessage('Meal removed as favorite');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        showInfoMessage('Meal added as favorite');
      });
    }
  }

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favoriteMeals, onToggleFavorite: _toggleFavoriteStatus);
      activePageTitle = 'Your Favorites';
    }

    void _setScreen(String identifier) {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const FilterScreen(),
          ),
        );
      }
      // else {
      //   Navigator.of(context).pop();
      // }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
