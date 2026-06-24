import 'package:flutter/material.dart';

enum BottomTabs {
  home,
  shop,
  cart,
  order,
  settings,
}


class BottomNavigationTabs extends StatelessWidget{
  final BottomTabs currentTab;
  BottomNavigationTabs({required this.currentTab});

  static const routes = {
    BottomTabs.home: '/home',
    BottomTabs.shop: '/category',
    BottomTabs.cart: '/item-detail',
    BottomTabs.order: '/filter',
    BottomTabs.settings: '/settings',
  };

  void _selectTab(BuildContext context,int index){
    final selectedTab = BottomTabs.values[index];
    if(selectedTab == currentTab){
      return;
    }
    Navigator.of(context).pushReplacementNamed(routes[selectedTab]!);
  }

  @override
  Widget build(BuildContext context) {

    // Implementation for bottom navigation tabs
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab.index,
      onTap: (index) => _selectTab(context, index),
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.shop), label:'Shop'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.list), label:'Order'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label:'Settings'),
     ], 
    );
  } 
}