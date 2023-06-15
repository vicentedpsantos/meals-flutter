import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/widgets/filter_list_tile.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/models/filter.dart';

class FiltersScreen extends ConsumerWidget {
  @override
  build(BuildContext context, WidgetRef ref) {
    Map<Filter, bool> filters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(
        children: filters.keys
            .toList()
            .map(
              (filter) => FilterListTile(
                filter: filter,
                isSet: filters[filter]!,
                onToggle: (filter) {
                  ref.read(filtersProvider.notifier).toggleFilter(filter);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
