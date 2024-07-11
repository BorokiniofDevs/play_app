import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_app/data/dummy_data.dart';
import 'package:play_app/models/meal.dart';
import 'package:play_app/providers/favorite_provider.dart';
import 'package:play_app/providers/filters_provider.dart';
import 'package:play_app/providers/meals_providers.dart';
import 'package:play_app/screens/categories.dart';
import 'package:play_app/screens/filters.dart';
import 'package:play_app/screens/meals.dart';
import 'package:play_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
// not needed
  // final List<Meal> _favoriteMeals = [];

  // void _toggleFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       showInfoMessage('Meal removed as favorite');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       showInfoMessage('Meal added as favorite');
  //     });
  //   }
  // }

  // void showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // SELECTEED FILTERS
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _setScreen(String identifier) async {
  //   Navigator.of(context).pop();
  //   if (identifier == 'filters') {
  //     final result = await Navigator.of(context).push<Map<Filter, bool>>(
  //       MaterialPageRoute(
  //         builder: (ctx) => const FilterScreen(
  //             // currentFilters: _selectedFilters,
  //             ),
  //       ),
  //     );
  //     // print(result);
  //     setState(() {
  //       _selectedFilters = result ?? kInitialFilters;
  //     });
  //   }
  //   // else {
  //   //   Navigator.of(context).pop();
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    // use provider meals instead of dummyMeals
    // final availableMeals = dummyMeals.where((meal) {
    //   if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    // }).toList();
    final meals = ref.watch(mealProvider);
    final activeFilters = ref.watch(filterProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      // NOT IN USE
      // onToggleFavorite: _toggleFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // use favorite from the favorite provider
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        // meals: _favoriteMeals,
        meals: favoriteMeals,
        // onToggleFavorite: _toggleFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    void _setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => const FilterScreen(),
          ),
        );
      }
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
