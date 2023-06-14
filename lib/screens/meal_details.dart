import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<MealDetailsScreen> createState() {
    return _MealDetailsScreenState();
  }
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  bool? isFavorite;

  @override
  void initState() {
    isFavorite =
        ref.read(favoriteMealsNotifier.notifier).isMealFavorite(widget.meal);

    super.initState();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite!;
    });

    ref
        .read(favoriteMealsNotifier.notifier)
        .toggleMealFavoriteStatus(widget.meal);
  }

  @override
  Widget build(context) {
    ref.watch(favoriteMealsNotifier);

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
