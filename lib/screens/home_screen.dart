import 'package:flutter/material.dart';
import 'package:learn_flutter/models/category_model.dart';
import 'package:learn_flutter/models/data.dart';
import 'package:learn_flutter/widgets/category_card.dart';
import 'package:learn_flutter/widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  // CONCEPT 9 – FILTER LOGIC: filter categories by search text
  List<CategoryModel> get _filtered {
    if (_searchQuery.isEmpty) {
      return appCategories;
    } else {
      return appCategories
          .where(
            (c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cats = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopNav'),
        actions: [
          // CONCEPT 4 – NAVIGATE TO NEW PAGE via Named Route
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Advanced Filter',
            onPressed: () => Navigator.pushNamed(context, '/filter'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search bar (also a filter) ───────────────────────
          Container(
            color: const Color(0xFF6C63FF),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SearchBar(
              onChanged: (v) => setState(() => _searchQuery = v),
              leading: const Icon(Icons.search, color: Colors.white),
            ),
          ),

          // ── CONCEPT 2: GRIDVIEW ──────────────────────────────
          Expanded(
            child: cats.isEmpty
                ? const EmptyState(message: 'No categories found 🔍')
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                      itemCount: cats.length,
                      itemBuilder: (ctx, i) => CategoryCard(category: cats[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
