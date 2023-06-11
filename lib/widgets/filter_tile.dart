import 'package:flutter/material.dart';

class FilterTile extends StatefulWidget {
  const FilterTile(
      {super.key,
      required this.title,
      required this.description,
      required this.isSet,
      required this.filterName,
      required this.setFilterValue});

  final String title;
  final String description;
  final String filterName;
  final bool isSet;
  final void Function(String filterName, bool isSet) setFilterValue;

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  bool? isSet;

  @override
  void initState() {
    isSet = widget.isSet;

    super.initState();
  }

  @override
  Widget build(context) {
    return SwitchListTile(
      value: isSet!,
      onChanged: (newValue) {
        setState(() {
          isSet = !isSet!;

          widget.setFilterValue(widget.filterName, isSet!);
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
