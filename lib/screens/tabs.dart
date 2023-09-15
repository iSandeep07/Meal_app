import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/providers/favorites_provider.dart';
//import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import '../models/meal.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarian : false,
  Filter.vegan : false,
};


class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _selectedPageIndex = 0;

  //final List<Meal> _favoriteMeals = [];

  Map<Filter ,bool> _selectedFilters = kInitialFilters;

  //void _showInfoMessage(String message){
    //ScaffoldMessenger.of(context).clearSnackBars();
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
   // ));
  //}

  //void _toggleMealFavoriteStatus(Meal meal){
   // final isExisting = _favoriteMeals.contains(meal);

   // if(isExisting == true){
    //  setState(() {
    //    _favoriteMeals.remove(meal);
     // });
    //  _showInfoMessage('Meal is no logner a favorite.');
   // } else{
     // setState(() {
     //   _favoriteMeals.add(meal);
    //  });
    //  _showInfoMessage('Marked as favorite');
  //  }

  //}

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
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
            label: 'Categories',
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