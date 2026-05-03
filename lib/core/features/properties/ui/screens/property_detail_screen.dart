import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
import 'package:pro_app/core/features/unit/providers/unit_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';
import 'package:pro_app/core/widgets/circle_icon_button.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';
import 'package:pro_app/core/features/properties/ui/widgets/image_gallery.dart';
import 'package:pro_app/core/features/properties/ui/widgets/amenities_grid.dart';
import 'package:pro_app/core/features/properties/ui/widgets/expandable_description.dart';
import 'package:pro_app/core/features/properties/ui/widgets/unit_types_section.dart';


class PropertyDetailScreen extends ConsumerWidget {
  const PropertyDetailScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyAsync = ref.watch(propertyDetailProvider(propertyId));

    return propertyAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: BrandedLoadingSpinner())),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text('Could not load property: $error'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    ref.refresh(propertyDetailProvider(propertyId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (property) {
        if (property == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Property not found.')),
          );
        }
        return _PropertyDetailView(property: property);
      },
    );
  }
}


class _PropertyDetailView extends ConsumerStatefulWidget {
  const _PropertyDetailView({required this.property});
  final PropertyModel property;

  @override
  ConsumerState<_PropertyDetailView> createState() =>
      _PropertyDetailViewState();
}

class _PropertyDetailViewState extends ConsumerState<_PropertyDetailView> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  bool _isSaved = false;
  bool _isDescriptionExpanded = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final p = widget.property;

    final unitsAsync = ref.watch(availableUnitsProvider(p.id));

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: theme.scaffoldBackgroundColor,
                leading: CircleIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => context.pop(),
                ),
                actions: [
                  CircleIconButton(icon: Icons.share_outlined, onTap: () {}),
                  const SizedBox(width: 4),
                  CircleIconButton(
                    icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    iconColor: _isSaved ? theme.colorScheme.primary : null,
                    onTap: () => setState(() => _isSaved = !_isSaved),
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ImageGallery(
                    imageUrls: p.imageUrls,
                    pageController: _pageController,
                    currentIndex: _currentImageIndex,
                    onPageChanged: (i) =>
                        setState(() => _currentImageIndex = i),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _TypeBadge(type: p.propertyType, theme: theme),
                          const Spacer(),
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.8 (124 reviews)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        p.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: appColors.muted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${p.address}, ${p.city}, ${p.state}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: appColors.muted,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _StatsRow(
                        property: p,
                        theme: theme,
                        appColors: appColors,
                      ),
                      const SizedBox(height: 24),

                      _SectionTitle(title: 'Amenities', theme: theme),
                      const SizedBox(height: 12),
                      AmenitiesGrid(
                        amenities: p.amenities,
                        theme: theme,
                        appColors: appColors,
                      ),
                      const SizedBox(height: 24),

                      _SectionTitle(title: 'Description', theme: theme),
                      const SizedBox(height: 8),
                      ExpandableDescription(
                        text: p.description,
                        isExpanded: _isDescriptionExpanded,
                        onToggle: () => setState(
                          () =>
                              _isDescriptionExpanded = !_isDescriptionExpanded,
                        ),
                        theme: theme,
                        appColors: appColors,
                      ),
                      const SizedBox(height: 28),

                      _SectionTitle(title: 'Available Units', theme: theme),
                      const SizedBox(height: 12),
                      UnitTypesSection(
                        propertyId: p.id,
                        unitsAsync: unitsAsync,
                        property: p,
                        theme: theme,
                        appColors: appColors,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Shared small widgets ──────────────────────────────────────────────────────



class _TypeBadge extends StatelessWidget {
  final PropertyType type;
  final ThemeData theme;

  const _TypeBadge({required this.type, required this.theme});

  String get _label {
    switch (type) {
      case PropertyType.apartment:
        return 'Apartment';
      case PropertyType.house:
        return 'House / Duplex';
      case PropertyType.selfCon:
        return 'Self-Contained';
      case PropertyType.shortLet:
        return 'Short Let';
      case PropertyType.commercial:
        return 'Commercial';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;

  const _SectionTitle({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final PropertyModel property;
  final ThemeData theme;
  final dynamic appColors;

  const _StatsRow({
    required this.property,
    required this.theme,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          _StatItem(
            icon: Icons.apartment_outlined,
            label: '${property.availableUnit} Available',
            theme: theme,
            appColors: appColors,
          ),
          _Divider(),
          _StatItem(
            icon: Icons.chair_outlined,
            label: property.isFurnished ? 'Furnished' : 'Unfurnished',
            theme: theme,
            appColors: appColors,
          ),
          _Divider(),
          _StatItem(
            icon: Icons.calendar_today_outlined,
            label: PropertyFormatters.rentPeriodLabel(property.rentPeriod),
            theme: theme,
            appColors: appColors,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  final dynamic appColors;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.theme,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
