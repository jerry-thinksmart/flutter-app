import 'package:flutter/material.dart';
import 'package:learn_flutter/models/item_model.dart';
//  DATA MODELS
// ═══════════════════════════════════════════════════════════════



class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final List<ItemModel> items;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.items,
  });
}