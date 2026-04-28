import 'package:flutter/material.dart';

class ApplicationReviewScreen extends StatelessWidget {
  const ApplicationReviewScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Application Review: $applicationId')),
    );
  }
}
