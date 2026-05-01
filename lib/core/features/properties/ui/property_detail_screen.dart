import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Property Detail: $propertyId')));
  }
}
