import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminTenantsScreen extends ConsumerWidget {
  const AdminTenantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Column(
        children: [
          // tenant count
          Row(mainAxisAlignment: .end, children: [Text('')]),
        ],
      ),
    );
  }
}
