// ═══════════════════════════════════════════════════════════════
//  CONCEPT 9: FILTER LOGIC (Advanced)
//  FilterScreen — multi-filter: category + tag + max price
// ═══════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:learn_flutter/models/data.dart';
import 'package:learn_flutter/models/item_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Set<String> _selectedCats  = {};
  final Set<String> _selectedTags  = {};
  double _maxPrice = 200;

  // CONCEPT 9 – FILTER LOGIC: combine multiple filter conditions
  List<ItemModel> get _results {
    final pools = _selectedCats.isEmpty
        ? appCategories
        : appCategories.where((c) => _selectedCats.contains(c.id));

    return pools
        .expand((c) => c.items)
        .where((item) {
          final tagOk =
              _selectedTags.isEmpty || _selectedTags.contains(item.tag);
          final priceOk = item.price <= _maxPrice;
          return tagOk && priceOk;
        })
        .toList();
  }

  void _reset() => setState(() {
        _selectedCats.clear();
        _selectedTags.clear();
        _maxPrice = 200;
      });

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Filter'),
        actions: [
          TextButton(
            onPressed: _reset,
            child: const Text('Reset',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Category chips ──────────────────────────────
                _SectionHeader(
                    title: 'Categories', icon: Icons.category_outlined),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: appCategories.map((cat) {
                    final sel = _selectedCats.contains(cat.id);
                    return FilterChip(
                      avatar: Text(cat.emoji,
                          style: const TextStyle(fontSize: 16)),
                      label: Text(cat.name),
                      selected: sel,
                      selectedColor: cat.color.withOpacity(0.22),
                      checkmarkColor: cat.color,
                      labelStyle: TextStyle(
                        color: sel ? cat.color : Colors.black87,
                        fontWeight: sel
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      side: BorderSide(
                          color: sel
                              ? cat.color
                              : Colors.grey.shade300),
                      onSelected: (v) => setState(() => v
                          ? _selectedCats.add(cat.id)
                          : _selectedCats.remove(cat.id)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // ── Tag chips ────────────────────────────────────
                _SectionHeader(
                    title: 'Price Tier',
                    icon: Icons.sell_outlined),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children:
                      ['budget', 'mid-range', 'premium'].map((tag) {
                    final sel = _selectedTags.contains(tag);
                    return FilterChip(
                      label: Text(tag),
                      selected: sel,
                      selectedColor: primary.withOpacity(0.18),
                      checkmarkColor: primary,
                      onSelected: (v) => setState(() => v
                          ? _selectedTags.add(tag)
                          : _selectedTags.remove(tag)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // ── Price slider ─────────────────────────────────
                _SectionHeader(
                  title:
                      'Max Price: \$${_maxPrice.toStringAsFixed(0)}',
                  icon: Icons.attach_money,
                ),
                Slider(
                  value: _maxPrice,
                  min: 10,
                  max: 200,
                  divisions: 19,
                  activeColor: primary,
                  label: '\$${_maxPrice.toStringAsFixed(0)}',
                  onChanged: (v) => setState(() => _maxPrice = v),
                ),

                const SizedBox(height: 24),

                // ── Results preview ──────────────────────────────
                _SectionHeader(
                  title: 'Results (${results.length})',
                  icon: Icons.list_alt_outlined,
                ),
                const SizedBox(height: 8),
                if (results.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text('No items match your filters',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  )
                else
                  ...results.map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text(item.emoji,
                          style: const TextStyle(fontSize: 28)),
                      title: Text(item.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600)),
                      subtitle: Text(item.tag),
                      trailing: Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Done / back button ───────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // CONCEPT 7 – NAVIGATING THROUGH PAGES: pop back
                  onPressed: () => Navigator.pop(context),
                  child: Text('Show ${results.length} Results'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message,
          style: const TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}