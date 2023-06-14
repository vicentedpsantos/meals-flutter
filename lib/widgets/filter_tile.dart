import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/filters_provider.dart';

class FilterTile extends ConsumerStatefulWidget {
  const FilterTile({
    super.key,
    required this.title,
    required this.description,
    required this.filterName,
  });

  final String title;
  final String description;
  final Filter filterName;

  @override
  ConsumerState<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends ConsumerState<FilterTile> {
  bool? isSet;

  @override
  void initState() {
    isSet = ref.read(filtersProvider.notifier).isSet(widget.filterName);

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
              .setFilter(widget.filterName, isSet!);
        });
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.description,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 32),
    );
  }
}
