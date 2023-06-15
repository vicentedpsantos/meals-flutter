enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class Filter {
  const Filter({
    required this.description,
    required this.title,
    required this.filterType,
  });

  final String description;
  final String title;
  final FilterType filterType;
}
