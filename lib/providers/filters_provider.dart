import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/filter.dart';
import 'package:meals/providers/meals_provider.dart';

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super(
          {
            const Filter(
              title: 'Gluten-free',
              description: 'Only include gluten-free meals',
              filterType: FilterType.glutenFree,
            ): false,
            const Filter(
              title: 'Lactose-free',
              description: 'Only include lactose-free meals',
              filterType: FilterType.lactoseFree,
            ): false,
            const Filter(
              title: 'Vegetarian',
              description: 'Only include vegetarian meals',
              filterType: FilterType.vegetarian,
            ): false,
            const Filter(
              title: 'Vegan',
              description: 'Only include vegan meals',
              filterType: FilterType.vegan,
            ): false,
          },
        );

  bool getStatusByType(FilterType filterType) {
    bool result = false;

    state.forEach(
      (k, v) {
        if (k.filterType == filterType) {
          result = v;
        }
      },
    );

    return result;
  }

  void toggleFilter(Filter filter) {
    bool currentFilterStatus = getStatusByType(filter.filterType);

    state = {...state, filter: !currentFilterStatus};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);
  var notifier = ref.read(filtersProvider.notifier);

  return meals.where((meal) {
    if (notifier.getStatusByType(FilterType.glutenFree) && !meal.isGlutenFree) {
      return false;
    }

    if (notifier.getStatusByType(FilterType.lactoseFree) &&
        !meal.isLactoseFree) {
      return false;
    }

    if (notifier.getStatusByType(FilterType.vegan) && !meal.isVegan) {
      return false;
    }

    if (notifier.getStatusByType(FilterType.vegetarian) && !meal.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
