import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/providers/location_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/section_label.dart';

class LocationPickerSheet extends ConsumerWidget {
  const LocationPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LocationPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    final filteredLocation = ref.watch(filteredLocationProvider);

    // shee height -- 75% of screen height
    final sheetHeight = MediaQuery.of(context).size.height * 0.75;

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: .vertical(top: .circular(28)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // drag handle
          Center(
            child: Container(
              padding: .only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.appColors.muted.withValues(alpha: 0.3),
                borderRadius: .circular(2),
              ),
            ),
          ),

          // title row
          Padding(
            padding: const .fromLTRB(20, 12, 12, 0),
            child: Row(
              children: [
                Text(
                  'Choose Location',
                  style: TextStyle(fontSize: 20, fontWeight: .w800),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.appColors.muted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // search bar
          Padding(
            padding: const .symmetric(horizontal: 20),
            child: _LocationSearchBar(ref: ref),
          ), //

          const SizedBox(height: 12),

          // all locations option
          _AllLocationsTile(
            isSelected: selectedLocation == null,
            onTap: () {
              ref.read(selectedLocationProvider.notifier).state = null;
              context.pop();
            },
          ),
          // section label
          Padding(
            padding: const .fromLTRB(20, 8, 20, 4),
            child: SectionLabel('POPULAR LOCATIONS'),
          ),

          // SCROLLABLE CITY LIST
          Expanded(
            child: filteredLocation.isEmpty
                ? _EmptySearchResult()
                : ListView.builder(
                    padding: const .symmetric(horizontal: 12),
                    itemCount: filteredLocation.length,
                    itemBuilder: (context, index) {
                      final loc = filteredLocation[index];
                      final isSelected = loc == selectedLocation;
                      return _LocationTile(
                        isSelected: isSelected,
                        location: loc,
                        onTap: () {
                          ref.read(selectedLocationProvider.notifier).state =
                              loc;
                          context.pop();
                        },
                      );
                    },
                  ),
          ),

          // bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
        ],
      ),
    );
  }
}

//
class _LocationSearchBar extends StatefulWidget {
  final WidgetRef ref;
  const _LocationSearchBar({required this.ref});
  @override
  State<_LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<_LocationSearchBar> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      onChanged: (value) {
        widget.ref.read(locationSearchQueryProvider.notifier).state == value;
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: 'Search city or neighborhood...',
        prefixIcon: Icon(
          Icons.search_rounded,
          color: context.appColors.muted,
          size: 20,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            widget.ref.read(locationSearchQueryProvider.notifier).state = '';
            setState(() {});
          },
          icon: Icon(
            Icons.clear_all_rounded,
            color: context.appColors.muted,
            size: 20,
          ),
        ),
        contentPadding: const .symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// all locations tile
class _AllLocationsTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  const _AllLocationsTile({required this.isSelected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const .symmetric(horizontal: 20),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.public_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        'All Locations',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Browse every available listing',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: context.appColors.muted),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
    );
  }
}

//Locationt tile
class _LocationTile extends StatelessWidget {
  final LocationOption location;
  final bool isSelected;
  final VoidCallback onTap;
  const _LocationTile({
    required this.isSelected,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const .symmetric(horizontal: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : context.appColors.muted.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.location_on_outlined,
          size: 20,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : context.appColors.muted,
        ),
      ),
      title: Text(
        location.name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        location.state,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: context.appColors.muted),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

// empty state
class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 44,
            color: context.appColors.muted,
          ),
          const SizedBox(height: 8),
          Text(
            'No locations found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.appColors.muted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
