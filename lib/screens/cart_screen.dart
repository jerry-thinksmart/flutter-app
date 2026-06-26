import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/item_model.dart';
import '../models/data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  ItemModel getItemById(String id) {
   for(var category in appCategories) {
      for(var item in category.items) {
        if (item.id == id) {
          return item;
        }
      }
    }
    throw Exception('Item not found');
  }
  @override
  Widget build(BuildContext context) {
    
    final cartProvider = Provider.of<CartProvider>(context);

    final cartItems = cartProvider.items.entries.toList();

    return Scaffold(

      appBar: AppBar(
        title: const Text('Cart'),
      ),

      body: cartItems.isEmpty

          ? const Center(
              child: Text('Your cart is empty'),
            )

          : ListView.builder(

              itemCount: cartItems.length,


              itemBuilder: (ctx, index) {


                final productId =
                    cartItems[index].key;


                final quantity =
                    cartItems[index].value;



                final ItemModel product =
                    getItemById(productId);



                return Card(

                  margin: const EdgeInsets.all(10),


                  child: ListTile(


                    leading: Text(
                      product.emoji,
                      style: const TextStyle(
                        fontSize: 35,
                      ),
                    ),



                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),



                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          product.description,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          'Quantity: $quantity',
                        ),

                      ],
                    ),



                    trailing: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ),
                );
              },
            ),

      bottomNavigationBar:
          BottomNavigationTabs(currentTab: BottomTabs.cart),
    );
  }
}