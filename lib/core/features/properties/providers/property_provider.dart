import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/properties/data/property_repository.dart';

// propertyRepoProvider -- DI
final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  return PropertyRepository(FirebaseFirestore.instance);
});

// marketplaceProvider -- to display available properties(isPublished and available)
final marketPlaceProvider = StreamProvider.autoDispose<List<PropertyModel>>((
  ref,
) {
  return ref.watch(propertyRepositoryProvider).watchPublished();
});

// allPropertiesProvider
final allPropertiesProvider = StreamProvider.autoDispose<List<PropertyModel>>((
  ref,
) {
  return ref.watch(propertyRepositoryProvider).watchAll();
});

//propertyDetail provider
final propertyDetailProvider = FutureProvider.autoDispose
    .family<PropertyModel?, String>((ref, propertyId) async {
      return ref.watch(propertyRepositoryProvider).getProperty(propertyId);
    });
    