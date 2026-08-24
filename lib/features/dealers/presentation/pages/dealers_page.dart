import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dealers_controller.dart';

/// Placeholder screen for the Dealers feature.
class DealersPage extends GetView<DealersController> {
  const DealersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dealers')),
      body: const Center(child: Text('Dealers feature coming soon')),
    );
  }
}
