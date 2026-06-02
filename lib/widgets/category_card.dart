import 'package:flutter/material.dart';
import 'package:learn_flutter/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // CONCEPT 6 – NAMED ROUTE: push with arguments object
      onTap: () => Navigator.pushNamed(
        context,
        '/category',
        arguments: category, // passed to CategoryScreen
      ),
      child: Card(
        color: category.color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(category.emoji,
                  style: const TextStyle(fontSize: 52)),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${category.items.length} items',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}