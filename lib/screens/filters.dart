import 'package:flutter/material.dart';

import 'package:meals/widgets/filter_tile.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.initialFilters});

  final Map<String, bool> initialFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<String, bool> currentFilters = {};

  @override
  void initState() {
    currentFilters = {...widget.initialFilters};

    super.initState();
  }

  void _setFilterValue(String filterName, bool newValue) {
    setState(() {

      currentFilters[filterName] = newValue;
    });
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(currentFilters);

          return false;
        },
        child: Column(
          children: [
            FilterTile(
              description: 'Only include gluten-free meals',
              filterName: 'glutten-free',
              isSet: widget.initialFilters['glutten-free']!,
              setFilterValue: _setFilterValue,
              title: 'Glutten-free',
            ),
            FilterTile(
              description: 'Only include lactose-free meals.',
              filterName: 'lactose-free',
              isSet: widget.initialFilters['lactose-free']!,
              setFilterValue: _setFilterValue,
              title: 'Lactose-free',
            ),
            FilterTile(
              description: 'Only include vegetarian meals.',
              filterName: 'vegetarian',
              isSet: widget.initialFilters['vegetarian']!,
              setFilterValue: _setFilterValue,
              title: 'Vegetarian',
            ),
            FilterTile(
              description: 'Only include vegan meals.',
              filterName: 'vegan',
              isSet: widget.initialFilters['vegan']!,
              setFilterValue: _setFilterValue,
              title: 'Vegan',
            ),
          ],
        ),
      ),
    );
  }
}
