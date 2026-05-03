import 'package:flutter/material.dart';

class LeaseCreationScreen extends StatelessWidget {
  const LeaseCreationScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Lease Creation: $applicationId')),
    );
  }
}
