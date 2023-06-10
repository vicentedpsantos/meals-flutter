import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen(
      {super.key,
      required this.meal,
      required this.onToggleFavorite,
      required this.isMealFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final bool Function(Meal meal) isMealFavorite;

  State<MealDetailsScreen> createState() {
    return _MealDetailsScreenState();
  }
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  bool? isFavorite;

  @override
  void initState() {
    isFavorite = widget.isMealFavorite(widget.meal);

    super.initState();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite!;
    });

    widget.onToggleFavorite(widget.meal);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
        ),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: isFavorite!
                ? const Icon(Icons.star)
                : const Icon(Icons.star_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ...widget.meal.ingredients.map(
              (ingredient) => Text(
                ingredient,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ...widget.meal.steps.map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
