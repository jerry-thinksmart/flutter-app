class ItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String emoji;
  final String tag; // 'budget' | 'mid-range' | 'premium'

  const ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
    required this.tag,
  });
}