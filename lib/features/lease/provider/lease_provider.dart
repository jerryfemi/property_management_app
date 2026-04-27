import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/features/auth/providers/auth_providers.dart';
import 'package:pro_app/features/lease/data/lease_model.dart';
import 'package:pro_app/features/lease/data/lease_repository.dart';

// lease provider --DI
final leaseRepoProvider = Provider<LeaseRepository>(
  (ref) => LeaseRepository(FirebaseFirestore.instance),
);

// watch lease provider, (home dashboard)
final watchLeaseProvider = StreamProvider.autoDispose<LeaseModel?>((ref) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value(null);

  return ref.watch(leaseRepoProvider).watchActiveLease(uid);
});

// all lease provider for admin
final allLeasesProvider = StreamProvider.autoDispose<List<LeaseModel>>((ref) {
  return ref.watch(leaseRepoProvider).watchAll();
});

// leases epireing withing 30 days  (alert admin panel)
final expiringLeaseProvider =
    Provider.autoDispose<AsyncValue<List<LeaseModel?>>>((ref) {
      return ref
          .watch(allLeasesProvider)
          .whenData(
            (leases) => leases
                .where(
                  (lease) =>
                      lease.status == LeaseStatus.active &&
                      lease.isExpiringSoon,
                )
                .toList(),
          );
    });

class LeaseCreationNotifier extends AsyncNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> createLease({
    required String tenantId,
    required String unitId,
    required String propertyId,
    required RentPeriod rentPeriod,
    required double monthlyRent,
    required double securityDeposit,
    double? agreementFee,
    double? agencyFee,
    double? serviceCharge,
    int? paymentDueDay,
    required DateTime startDate,
    required DateTime endDate,
    String? contractUrl,
  }) async {
    // set the state to loading
    state = AsyncLoading();
    final adminUid = ref.watch(authStateProvider).value?.uid;
    if (adminUid == null) {
      state = AsyncError('Not Aunthenticated', StackTrace.current);
      return;
    }
// update the state
    state = await AsyncValue.guard(
      () => ref
          .read(leaseRepoProvider)
          .create(
            tenantId: tenantId,
            unitId: unitId,
            propertyId: propertyId,
            createdByAdminId: adminUid,
            rentPeriod: rentPeriod,
            monthlyRent: monthlyRent,
            securityDeposit: securityDeposit,
            agencyFee: agencyFee,
            agreementFee: agreementFee,
            contractUrl: contractUrl,
            paymentDueDay: paymentDueDay,
            serviceCharge: serviceCharge,
            startDate: startDate,
            endDate: endDate,
          ),
    );
  }
}
