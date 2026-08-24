import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/collections_controller.dart';

/// Placeholder screen for the Collections feature.
class CollectionsPage extends GetView<CollectionsController> {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collections')),
      body: const Center(child: Text('Collections feature coming soon')),
    );
  }
}
