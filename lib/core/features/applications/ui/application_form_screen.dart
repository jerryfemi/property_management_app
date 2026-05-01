import 'package:flutter/material.dart';

class ApplicationFormScreen extends StatelessWidget {
  const ApplicationFormScreen({super.key, required this.unitId});

  final String unitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Application Form: $unitId')));
  }
}
