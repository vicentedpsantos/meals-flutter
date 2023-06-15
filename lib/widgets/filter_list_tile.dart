import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/filters_provider.dart';
import 'package:meals/models/filter.dart';

class FilterListTile extends ConsumerStatefulWidget {
  const FilterListTile({ super.key, required this.filter, });

  final Filter filter;
  @override
  ConsumerState<FilterListTile> createState() => _FilterListTileState();
}

class _FilterListTileState extends ConsumerState<FilterListTile> {
  bool? isSet;

  @override
  void initState() {
    isSet = ref.read(filtersProvider.notifier).isSet(widget.filter);

    super.initState();
  }

  @override
  Widget build(context) {
    return SwitchListTile(
      value: isSet!,
      onChanged: (newValue) {
        setState(() {
          isSet = !isSet!;

          ref
              .read(filtersProvider.notifier)
              .setFilter(widget.filter, isSet!);
        });
      },
      title: Text(
        widget.filter.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.filter.description,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 32),
    );
  }
}
