import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
import 'package:pro_app/core/features/properties/ui/widgets/marketplace_sliver_app_bar.dart';
import 'package:pro_app/core/features/properties/ui/widgets/property_card.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';

class MarketplaceScreen extends ConsumerWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(marketPlaceProvider);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            // 1. Collapsing Header & Pinned Search/Chips
            const MarketplaceSliverAppBar(),

            // 3. Property Feed
            propertiesAsync.when(
              data: (properties) {
                if (properties.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No properties found.')),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final property = properties[index];
                      return PropertyCard(
                        property: property,
                        onTap: () {
                          context.push('/guest/explore/property/${property.id}');
                        },
                      );
                    }, childCount: properties.length),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: BrandedLoadingSpinner()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(child: Text('Error loading properties: $error')),
              ),
            ),
          ],
        ),
    );
  }
}
