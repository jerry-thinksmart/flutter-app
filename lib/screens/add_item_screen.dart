import 'package:flutter/material.dart';
import 'package:learn_flutter/models/category_model.dart';
import 'package:learn_flutter/models/item_model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emojiController = TextEditingController(text: '🛒');
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedTag = 'budget';

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveItem(CategoryModel category) {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final item = ItemModel(
      id: '${category.id}-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      emoji: _emojiController.text.trim(),
      tag: _selectedTag,
    );

    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as CategoryModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${category.name} Item'),
        backgroundColor: category.color,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Item name',
                prefixIcon: Icon(Icons.inventory_2_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter an item name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emojiController,
              decoration: const InputDecoration(
                labelText: 'Emoji',
                prefixIcon: Icon(Icons.emoji_symbols_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter an emoji';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final price = double.tryParse(value?.trim() ?? '');
                if (price == null || price <= 0) {
                  return 'Enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTag,
              decoration: const InputDecoration(
                labelText: 'Price tier',
                prefixIcon: Icon(Icons.sell_outlined),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'budget', child: Text('budget')),
                DropdownMenuItem(value: 'mid-range', child: Text('mid-range')),
                DropdownMenuItem(value: 'premium', child: Text('premium')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _selectedTag = value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.notes_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter a description';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: category.color),
              onPressed: () => _saveItem(category),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add Item'),
            ),
          ),
        ),
      ),
    );
  }
}
