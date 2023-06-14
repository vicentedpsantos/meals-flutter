import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/filter_tile.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: const Column(
        children: [
          FilterTile(
            description: 'Only include gluten-free meals',
            filterName: Filter.glutenFree,
            title: 'Glutten-free',
          ),
          FilterTile(
            description: 'Only include lactose-free meals.',
            filterName: Filter.lactoseFree,
            title: 'Lactose-free',
          ),
          FilterTile(
            description: 'Only include vegetarian meals.',
            filterName: Filter.vegetarian,
            title: 'Vegetarian',
          ),
          FilterTile(
            description: 'Only include vegan meals.',
            filterName: Filter.vegan,
            title: 'Vegan',
          ),
        ],
      ),
    );
  }
}
