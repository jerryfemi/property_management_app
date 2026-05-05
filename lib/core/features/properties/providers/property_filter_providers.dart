import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class PropertyFilterState {
  const PropertyFilterState({
    required this.searchQuery,
    required this.priceRange,
    required this.propertyTypes,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaRange,
    required this.amenities,
  });

  static const RangeValues defaultPriceRange = RangeValues(600000, 4000000);
  static const RangeValues defaultAreaRange = RangeValues(0, 200);

  final String searchQuery;
  final RangeValues priceRange;
  final Set<String> propertyTypes;
  final String bedrooms;
  final String bathrooms;
  final RangeValues areaRange;
  final Set<String> amenities;

  factory PropertyFilterState.initial() => const PropertyFilterState(
        searchQuery: '',
        priceRange: defaultPriceRange,
        propertyTypes: <String>{},
        bedrooms: 'Any',
        bathrooms: 'Any',
        areaRange: defaultAreaRange,
        amenities: <String>{},
      );

  PropertyFilterState copyWith({
    String? searchQuery,
    RangeValues? priceRange,
    Set<String>? propertyTypes,
    String? bedrooms,
    String? bathrooms,
    RangeValues? areaRange,
    Set<String>? amenities,
  }) {
    return PropertyFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      priceRange: priceRange ?? this.priceRange,
      propertyTypes: propertyTypes ?? this.propertyTypes,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      areaRange: areaRange ?? this.areaRange,
      amenities: amenities ?? this.amenities,
    );
  }
}

class PropertyFilterNotifier extends StateNotifier<PropertyFilterState> {
  PropertyFilterNotifier() : super(PropertyFilterState.initial());

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
  }

  void setPriceRange(RangeValues value) {
    state = state.copyWith(priceRange: value);
  }

  void setPropertyTypes(Set<String> value) {
    state = state.copyWith(propertyTypes: value);
  }

  void setBedrooms(String value) {
    state = state.copyWith(bedrooms: value);
  }

  void setBathrooms(String value) {
    state = state.copyWith(bathrooms: value);
  }

  void setAreaRange(RangeValues value) {
    state = state.copyWith(areaRange: value);
  }

  void setAmenities(Set<String> value) {
    state = state.copyWith(amenities: value);
  }

  void clearFilters() {
    state = state.copyWith(
      priceRange: PropertyFilterState.defaultPriceRange,
      propertyTypes: <String>{},
      bedrooms: 'Any',
      bathrooms: 'Any',
      areaRange: PropertyFilterState.defaultAreaRange,
      amenities: <String>{},
    );
  }
}

final propertyFiltersProvider =
    StateNotifierProvider<PropertyFilterNotifier, PropertyFilterState>(
  (ref) => PropertyFilterNotifier(),
);
