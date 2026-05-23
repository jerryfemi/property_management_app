import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/admin/providers/dashboard_providers.dart';
import 'package:pro_app/core/features/admin/ui/widgets/admin_property_card.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';

class AdminPropertiesScreen extends ConsumerWidget {
  const AdminPropertiesScreen({super.key});

  static const _adminCategories = [
    'All',
    'Vacant',
    'Fully Occupied',
    'Maintenance',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalProperties = ref.watch(allPropertiesProvider).value!.length;

    final propertyAsync = ref.watch(filteredAdminPropertiesProvider);
    return Scaffold(
      body: Column(
        children: [
          // filter chips
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 14, right: 14),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CategoryChips(
                  categories: _adminCategories,
                  selectedProvider: adminPropertyFilterProvider,
                  borderRadius: 8,
                  selectedColor: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
                Text(
                  '${totalProperties.toString()} ${totalProperties > 1 ? 'properties' : 'property'}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.appColors.muted,
                  ),
                ),
              ],
            ),
          ),
          // property grid
          Expanded(
            child: propertyAsync.when(
              error: (error, stackTrace) {
                debugPrint(error.toString());
                debugPrint(stackTrace.toString());
                return Center(child: Text('$error'));
              },
              loading: () => Center(child: BrandedLoadingSpinner()),
              data: (properties) {
                if (properties.isEmpty) {
                  return const Center(
                    child: Text('No properties match this filter'),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    mainAxisExtent: 320,
                  ),
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return AdminPropertyCard(
                      onTap: () =>
                          context.go('/admin/properties/${property.id}'),
                      property: property,
                      key: ValueKey(property.id),
                    );
                  },
                  itemCount: properties.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
