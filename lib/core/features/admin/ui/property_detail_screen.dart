import 'package:flutter/material.dart';

class AdminPropertyDetailScreen extends StatelessWidget {
  final String propertyId;
  const AdminPropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin Property Detail Screen: $propertyId'),
      ),
    );
  }
}
