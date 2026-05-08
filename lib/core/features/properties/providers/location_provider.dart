import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocationOption {
  final String name;
  final String state;

  const LocationOption({required this.name, required this.state});

  // get display name, shown in the header
  String get displayName => ' $name, $state';

  @override
  bool operator ==(Object other) =>
      other is LocationOption && other.name == name && other.state == state;

  @override
  int get hashCode => Object.hash(name, state);
}

// providers
// city user had already selected, if null? All locations, defaults to lagos

final selectedLocationProvider = StateProvider<LocationOption?>((ref) {
  return const LocationOption(name: 'Lagos', state: 'Nigeria');
});

// search query
final locationSearchQueryProvider = StateProvider.autoDispose((ref) => '');

// derived filtered list
final filteredLocationProvider = Provider.autoDispose<List<LocationOption>>((
  ref,
) {
  final query = ref.watch(locationSearchQueryProvider).toLowerCase().trim();
  if (query.isEmpty) return _allLocations;

  return _allLocations
      .where(
        (loc) =>
            loc.name.toLowerCase().contains(query) ||
            loc.state.toLowerCase().contains(query),
      )
      .toList();
});


// static city list

const List<LocationOption> _allLocations = [
  LocationOption(name: 'Lagos', state: 'Nigeria'),
  LocationOption(name: 'Lekki', state: 'Lagos'),
  LocationOption(name: 'Victoria Island', state: 'Lagos'),
  LocationOption(name: 'Ikoyi', state: 'Lagos'),
  LocationOption(name: 'Ikeja', state: 'Lagos'),
  LocationOption(name: 'Yaba', state: 'Lagos'),
  LocationOption(name: 'Surulere', state: 'Lagos'),
  LocationOption(name: 'Ajah', state: 'Lagos'),
  LocationOption(name: 'Abuja', state: 'FCT'),
  LocationOption(name: 'Port Harcourt', state: 'Rivers'),
  LocationOption(name: 'Kano', state: 'Kano'),
  LocationOption(name: 'Ibadan', state: 'Oyo'),
  LocationOption(name: 'Enugu', state: 'Enugu'),
];
