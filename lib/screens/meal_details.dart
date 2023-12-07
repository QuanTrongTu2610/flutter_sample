import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal, bool) onToggleFavorite;

  @override
  State<MealDetailsScreen> createState() {
    return _MealDetailState();
  }
}

class _MealDetailState extends State<MealDetailsScreen> {
  bool _isLove = false;
  Widget buildComponent(BuildContext context, String title, List items) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 14,
        ),
        for (final item in items)
          Text(
            item,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.star;
    if (_isLove) iconData = Icons.star_border;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isLove = !_isLove;
              });
              widget.onToggleFavorite(widget.meal, _isLove);
            },
            icon: Icon(iconData),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            widget.meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 14,
          ),
          for (final item in [
            ['Ingredients', widget.meal.ingredients],
            ['Steps', widget.meal.steps]
          ])
            buildComponent(context, item[0] as String, item[1] as List),
        ]),
      ),
    );
  }
}
