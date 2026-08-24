import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/visits_controller.dart';

/// Placeholder screen for the Visits feature.
class VisitsPage extends GetView<VisitsController> {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visits')),
      body: const Center(child: Text('Visits feature coming soon')),
    );
  }
}
