import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/features/unit/data/unit_repository.dart';

// unit repo provider  --DI
final unitRepositoryProvider = Provider<UnitRepository>((ref) {
  return UnitRepository(FirebaseFirestore.instance);
});

//  unitsForPopertyProvider to get all units for a particular property
final unitsForPropertyProvider = StreamProvider.autoDispose
    .family<List<UnitModel>, String>((ref, propertyId) {
      return ref.watch(unitRepositoryProvider).unitsForProperty(propertyId);
    });

// all units for property provider.
final availableUnitsProvider = StreamProvider.autoDispose
    .family<List<UnitModel>, String>((ref, propertyId) {
      return ref
          .watch(unitRepositoryProvider)
          .availableUnitsForProperty(propertyId);
    });

// units grouped units provider
final groupedUnitsProvider = Provider.autoDispose
    .family<AsyncValue<Map<int, List<UnitModel>>>, String>((ref, propertyId) {
      return ref
          .watch(availableUnitsProvider(propertyId))
          .whenData((units) => units.groupByBedrooms());
    });

// watch unit provider
final watchUnitProvider = StreamProvider.autoDispose.family<UnitModel?, String>(
  (ref, unitId) {
    return ref.watch(unitRepositoryProvider).watchUnit(unitId);
  },
);

// occupied units provider
final occupiedUnisProvider = StreamProvider.autoDispose<List<UnitModel>>(
  (ref) => ref.watch(unitRepositoryProvider).occupied(),
);

//
final unitManagementProvider = StateNotifierProvider.autoDispose
    .family<UnitManagementNotifier, AsyncValue<List<UnitModel>>, String>((
      ref,
      propertyId,
    ) {
      final repo = ref.read(unitRepositoryProvider);
      return UnitManagementNotifier(repo: repo, propertyId: propertyId);
    });

class UnitManagementNotifier
    extends StateNotifier<AsyncValue<List<UnitModel>>> {
  UnitManagementNotifier({
    required UnitRepository repo,
    required String propertyId,
  }) : _repo = repo,
       _propertyId = propertyId,
       super(const AsyncLoading()) {
    _sub = _repo
        .unitsForProperty(_propertyId)
        .listen(
          (units) => state = AsyncData(units),
          onError: (e, st) => state = AsyncError(e, st),
        );
  }

  final UnitRepository _repo;
  final String _propertyId;
  StreamSubscription<List<UnitModel>>? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> markMaintenance(String unitId) async {
    final current = state.maybeWhen(
      data: (units) => units,
      orElse: () => const <UnitModel>[],
    );

    //  Update UI immediately — don't wait for Firestore round-trip
    state = AsyncData(
      current
          .map(
            (u) => u.id == unitId
                ? u.copyWith(unitStatus: UnitStatus.maintenance)
                : u,
          )
          .toList(),
    );

    //  Write to Firestore — stream will re-emit and confirm the change
    try {
      await _repo.updateStatus(unitId, UnitStatus.maintenance);
    } catch (e, st) {
      // Revert to error so the UI can show a retry option
      state = AsyncError(e, st);
    }
  }

  Future<void> addUnit({
    required String unitNumber,
    required int bedrooms,
    required int bathrooms,
    required double baseRent,
    required List<String> amenities,
  }) async {
    state = const AsyncLoading();
    try {
      await _repo.addUnit(
        propertyId: _propertyId,
        unitNumber: unitNumber,
        bedrooms: bedrooms,
        bathrooms: bathrooms,
        baseRent: baseRent,
        amenities: amenities,
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addBatch(List<Map<String, dynamic>> units) async {
    state = const AsyncLoading();
    try {
      await _repo.addBatch(propertyId: _propertyId, units: units);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// --- DUMMY DATA FOR TESTING ---
final dummyUnits = [
  UnitModel(
    id: 'u1_1',
    propertyId: 'prop_1',
    unitNumber: 'A101',
    bedrooms: 2,
    bathrooms: 2,
    baseRent: 2500000,
    amenities: ['AC', 'Balcony'],
    unitStatus: UnitStatus.available,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UnitModel(
    id: 'u1_2',
    propertyId: 'prop_1',
    unitNumber: 'A102',
    bedrooms: 3,
    bathrooms: 3,
    baseRent: 3500000,
    amenities: ['AC', 'Walk-in Closet'],
    unitStatus: UnitStatus.available,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  UnitModel(
    id: 'u2_1',
    propertyId: 'prop_2',
    unitNumber: 'S-1',
    bedrooms: 0,
    bathrooms: 1,
    baseRent: 450000,
    amenities: ['Fast Wifi', 'Water'],
    unitStatus: UnitStatus.available,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
