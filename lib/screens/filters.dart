import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/filter_list_tile.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/models/filter.dart';

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
    Map<Filter, bool> filters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: filters.keys
            .toList()
            .map(
              (filter) => FilterListTile(filter: filter),
            )
            .toList(),
      ),
    );
  }
}
