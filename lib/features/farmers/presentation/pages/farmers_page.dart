import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/farmers_controller.dart';

/// Placeholder screen for the Farmers feature.
class FarmersPage extends GetView<FarmersController> {
  const FarmersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmers')),
      body: const Center(child: Text('Farmers feature coming soon')),
    );
  }
}
