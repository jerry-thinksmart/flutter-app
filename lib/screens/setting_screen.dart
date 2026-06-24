import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/bottom_navigation.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
      bottomNavigationBar: BottomNavigationTabs(currentTab: BottomTabs.settings),
    );
  }
}