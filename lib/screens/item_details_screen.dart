// ═══════════════════════════════════════════════════════════════
//  CONCEPT 4 + 6 + 7: NAVIGATE TO NEW PAGE + NAMED ROUTE +
//  NAVIGATING THROUGH PAGES
//  ItemDetailScreen
// ═══════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:learn_flutter/models/item_model.dart';
import 'package:learn_flutter/widgets/tag.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // CONCEPT 6 – NAMED ROUTE: extract arguments passed by name
    final args = ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>;
    final item  = args['item']  as ItemModel;
    final color = args['color'] as Color;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Collapsible header ───────────────────────────────
          SliverAppBar(
            expandedHeight: 230,
            pinned: true,
            backgroundColor: color,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    Text(item.emoji,
                        style: const TextStyle(fontSize: 90)),
                  ],
                ),
              ),
            ),
          ),

          // ── Detail content ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.name,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
                      ),
                      Tag(label: item.tag, color: color),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const SizedBox(height: 20),
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(item.description,
                      style: const TextStyle(
                          fontSize: 16, height: 1.65)),
                  const SizedBox(height: 36),

                  // Add to Cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: color),
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Add to Cart'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${item.name} added to cart!'),
                            backgroundColor: color,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // CONCEPT 7 – NAVIGATING THROUGH PAGES:
                  // pushNamedAndRemoveUntil clears the whole stack
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color,
                        side: BorderSide(color: color),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                      ),
                      icon: const Icon(Icons.home_outlined),
                      label: const Text('Back to Home'),
                      onPressed: () =>
                          Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false, // removes ALL previous routes
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
