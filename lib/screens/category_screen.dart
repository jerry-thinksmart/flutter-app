// ═══════════════════════════════════════════════════════════════
//  CONCEPT 5 + 9: CONSTRUCTOR + FILTER LOGIC
//  CategoryScreen — receives CategoryModel via constructor OR
//  via route arguments (both patterns shown).
// ═══════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:learn_flutter/models/category_model.dart';
import 'package:learn_flutter/models/item_model.dart';
import 'package:learn_flutter/widgets/empty_state.dart';

class CategoryScreen extends StatefulWidget {
  // CONCEPT 5 – CONSTRUCTOR: optional direct-pass parameter
  final CategoryModel? category;

  const CategoryScreen({super.key, this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedTag = 'all';
  late CategoryModel _cat;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Supports BOTH constructor injection AND named-route arguments
    _cat = widget.category ??
        ModalRoute.of(context)!.settings.arguments as CategoryModel;
  }

  // CONCEPT 9 – FILTER LOGIC: filter items by price tag
  List<ItemModel> get _filteredItems {
    if (_selectedTag == 'all') return _cat.items;
    return _cat.items.where((i) => i.tag == _selectedTag).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_cat.emoji}  ${_cat.name}'),
        backgroundColor: _cat.color,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Filter chips ─────────────────────────────────────
          Container(
            color: _cat.color.withOpacity(0.08),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filter by price range:',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        ['all', 'budget', 'mid-range', 'premium']
                            .map((tag) => Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(
                                      tag == 'all' ? 'All' : tag,
                                      style: TextStyle(
                                        color: _selectedTag == tag
                                            ? Colors.white
                                            : Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    selected: _selectedTag == tag,
                                    selectedColor: _cat.color,
                                    onSelected: (_) => setState(
                                        () => _selectedTag = tag),
                                  ),
                                ))
                            .toList(),
                  ),
                ),
              ],
            ),
          ),

          // ── Items list ───────────────────────────────────────
          Expanded(
            child: items.isEmpty
                ? const EmptyState(
                    message: 'No items in this range')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (ctx, i) => _ItemTile(
                      item: items[i],
                      categoryColor: _cat.color,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final ItemModel item;
  final Color categoryColor;
  const _ItemTile({required this.item, required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: categoryColor.withOpacity(0.15),
          radius: 28,
          child: Text(item.emoji,
              style: const TextStyle(fontSize: 26)),
        ),
        title: Text(item.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item.tag,
                style: TextStyle(
                  fontSize: 11,
                  color: categoryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: categoryColor),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        // CONCEPT 7 – NAVIGATING THROUGH PAGES: push ItemDetail
        onTap: () => Navigator.pushNamed(
          context,
          '/item-detail',
          arguments: {'item': item, 'color': categoryColor},
        ),
      ),
    );
  }
}