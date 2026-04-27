import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/features/applications/data/application_model.dart';
import 'package:pro_app/features/applications/data/application_repository.dart';
import 'package:pro_app/features/auth/providers/auth_providers.dart';

final applicatioRepositoryProvider = Provider<ApplicationRepository>((ref) {
  return ApplicationRepository(FirebaseFirestore.instance);
});

// for users to watch their applications
final watchMyApplicationProvider =
    StreamProvider.autoDispose<List<ApplicationModel>>((ref) {
      final uid = ref.watch(authStateProvider).value?.uid;
      if (uid == null) return Stream.value([]);
      return ref.watch(applicatioRepositoryProvider).watchMyApplication(uid);
    });

// watchByStatusProvider
final allApplicationsProvider =
    StreamProvider.autoDispose<List<ApplicationModel>>((ref) {
      return ref.watch(applicatioRepositoryProvider).watchAll();
    });

// pendingApplicationsProvider  -- too see pending applications
final pendingApplicationsProvider =
    Provider.autoDispose<AsyncValue<List<ApplicationModel>>>((ref) {
      return ref
          .watch(allApplicationsProvider)
          .whenData(
            (apps) => apps
                .where((a) => a.applicationStatus == ApplicationStatus.pending)
                .toList(),
          );
    });

// approvedApplicationsProvider
final approvedApplicationsProvider =
    Provider.autoDispose<AsyncValue<List<ApplicationModel>>>((ref) {
      return ref
          .watch(allApplicationsProvider)
          .whenData(
            (apps) => apps
                .where((a) => a.applicationStatus == ApplicationStatus.approved)
                .toList(),
          );
    });

// multi step application form

class ApplicationFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> submit({
    required String unitId,
    required String propertyId,
    required String fullName,
    required String phone,
    required String currentAddress,
    required String employmentStatus,
    required double monthlyIncome,
    required int occupants,
    required bool hasPets,
    String? idDocumentUrl,
    String? incomeProofUrl,
    String? message,
  }) async {
    // set state to loading
    state = const AsyncLoading();

    final uid = ref.watch(authStateProvider).value?.uid;
    if (uid == null) {
      state = AsyncError('Not Authenticated', StackTrace.current);
      return;
    }

    state = await AsyncValue.guard(
      () => ref
          .watch(applicatioRepositoryProvider)
          .submit(
            applicantId: uid,
            unitId: unitId,
            propertyId: propertyId,
            fullName: fullName,
            phone: phone,
            currentAddress: currentAddress,
            employmentStatus: employmentStatus,
            monthlyIncome: monthlyIncome,
            occupants: occupants,
            hasPets: hasPets,
            idDocumentUrl: idDocumentUrl,
            incomeProofUrl: incomeProofUrl,
            message: message,
          ),
    );
  }
}

class ApplicationReviewNotifier
    extends StateNotifier<AsyncValue<ApplicationModel?>> {
  final ApplicationRepository _repo;
  final String _applicationId;
  ApplicationReviewNotifier({
    required ApplicationRepository repo,
    required String applicationId,
  }) : _repo = repo,
       _applicationId = applicationId,
       super(const AsyncLoading()) {
    // load application immedidately
    _load();
  }

  Future<void> _load() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => _repo.fetch(_applicationId));
  }

  // approve application
  Future<void> approve(String? landlordNote) async {
    state = AsyncLoading();

    try {
      await _repo.updateStatus(
        _applicationId,
        ApplicationStatus.approved,
        landlordNote: landlordNote,
      );

      // re fetch to confirm firestore write if reflected in state
      state = await AsyncValue.guard(() => _repo.fetch(_applicationId));
    } catch (e, st) {
      AsyncError(e, st);
    }
  }

  // reject
  Future<void> reject(String? reason) async {
    state = AsyncLoading();

    try {
      _repo.updateStatus(
        _applicationId,
        ApplicationStatus.rejected,
        rejectionReason: reason,
      );

      state = await AsyncValue.guard(() => _repo.fetch(_applicationId));
    } catch (e, st) {
      AsyncError(e, st);
    }
  }
}
