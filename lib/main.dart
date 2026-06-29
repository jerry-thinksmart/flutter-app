import 'package:flutter/material.dart';
import 'package:learn_flutter/screens/add_category_screen.dart';
import 'package:learn_flutter/screens/add_item_screen.dart';
import 'package:learn_flutter/screens/category_form.dart';
import 'package:learn_flutter/screens/category_screen.dart';
import 'package:learn_flutter/screens/filter_screen.dart';
import 'package:learn_flutter/screens/home_screen.dart';
import 'package:learn_flutter/screens/item_details_screen.dart';
import 'package:learn_flutter/screens/splash_screen.dart';
import 'package:learn_flutter/screens/cart_screen.dart';
import 'package:learn_flutter/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import './providers/cart_provider.dart';

void main() {
  runApp(
  ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFFE91E8C),
        ),
      
         appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
      ),
       cardTheme: CardThemeData(
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

         chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      // home: const HomeScreen(),

       initialRoute: '/',
      routes: {
        '/':            (ctx) => const SplashScreen(),
        '/home':        (ctx) => const HomeScreen(),
        '/category':    (ctx) => const CategoryScreen(),
        '/cart':        (ctx) => const CartScreen(),
        '/item-detail': (ctx) => const ItemDetailScreen(),
        '/add-category': (ctx) => const AddCategoryScreen(),
        '/add-item':    (ctx) => const AddItemScreen(),
        '/filter':      (ctx) => const FilterScreen(),
        '/settings':      (ctx) =>  CategoryForm(),
      },
    );
  }
}
