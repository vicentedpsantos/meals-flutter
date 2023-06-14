import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  'glutten-free': false,
  'lactose-free': false,
  'vegetarian': false,
  'vegan': false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<String, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }

  bool _isMealFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  void _setScreen(String identifier) async {
    switch (identifier) {
      case 'filters':
        Navigator.of(context).pop();

        var filters = await Navigator.of(context).push<Map<String, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(initialFilters: _selectedFilters),
          ),
        );

        setState(() {
          _selectedFilters = filters ?? kInitialFilters;
        });

        break;
      default:
        Navigator.of(context).pop();

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_selectedFilters['glutten-free']! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters['lactose-free']! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }

      if (_selectedFilters['vegan']! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      isMealFavorite: _isMealFavorite,
      availableMeals: availableMeals,
    );

    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
        isMealFavorite: _isMealFavorite,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
    );
  }
}
