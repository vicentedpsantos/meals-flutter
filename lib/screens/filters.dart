import 'package:flutter/material.dart';

import 'package:meals/widgets/filter_tile.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var filters = {
    'glutten-free': false,
    'lactose-free': false,
    'vegetarian': false,
    'vegan': false
  };

  void _setFilterValue(String filterName, bool newValue) {
    setState(() {
      filters[filterName] = newValue;
    });
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: [
          FilterTile(
            description: 'Only include gluten-free meals',
            filterName: 'glutten-free',
            isSet: false,
            setFilterValue: _setFilterValue,
            title: 'Glutten-free',
          ),
          FilterTile(
            description: 'Only include lactose-free meals.',
            filterName: 'lactose-free',
            isSet: false,
            setFilterValue: _setFilterValue,
            title: 'Lactose-free',
          ),
          FilterTile(
            description: 'Only include vegetarian meals.',
            filterName: 'vegetarian',
            isSet: false,
            setFilterValue: _setFilterValue,
            title: 'Vegetarian',
          ),
          FilterTile(
            description: 'Only include vegan meals.',
            filterName: 'vegan',
            isSet: false,
            setFilterValue: _setFilterValue,
            title: 'Vegan',
          ),
        ],
      ),
    );
  }
}
