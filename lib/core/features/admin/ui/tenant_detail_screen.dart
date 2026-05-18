import 'package:flutter/material.dart';

class AdminTenantDetailScreen extends StatelessWidget {
  final String tenantId;
  const AdminTenantDetailScreen({super.key, required this.tenantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin Tenant Detail Screen: $tenantId'),
      ),
    );
  }
}
