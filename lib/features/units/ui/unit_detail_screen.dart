import 'package:flutter/material.dart';

class UnitDetailScreen extends StatelessWidget {
  const UnitDetailScreen({super.key, required this.unitId});

  final String unitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Unit Detail: $unitId')));
  }
}
