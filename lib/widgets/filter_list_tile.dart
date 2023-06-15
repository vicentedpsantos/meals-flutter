import 'package:flutter/material.dart';

import 'package:meals/models/filter.dart';

class FilterListTile extends StatelessWidget {
  const FilterListTile(
      {super.key,
      required this.isSet,
      required this.filter,
      required this.onToggle});

  final Filter filter;
  final bool isSet;
  final void Function(Filter filter) onToggle;

  @override
  Widget build(context) {
    return SwitchListTile(
      value: isSet,
      onChanged: (newValue) {
        onToggle(filter);
      },
      title: Text(
        filter.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        filter.description,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 32),
    );
  }
}
