// ticket repo provider -- Di
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/features/maintenance/data/ticket_model.dart';
import 'package:pro_app/features/maintenance/data/ticket_repository.dart';

final ticketRepositoryProvider = Provider<TicketRepository>(
  (ref) => TicketRepository(FirebaseFirestore.instance),
);

// provider to watch tickets for a specific tenant.
final watchForTenantProvider = StreamProvider.autoDispose
    .family<List<TicketModel>, String>((ref, tenantId) {
      return ref.watch(ticketRepositoryProvider).watchForTenant(tenantId);
    });

// provider to watch tickets assigned to a staff
final assignedToTicketProvider = StreamProvider.autoDispose
    .family<List<TicketModel>, String>((ref, staffId) {
      return ref.watch(ticketRepositoryProvider).watchAssignedTo(staffId);
    });

// provider to watch all tickets
final watchAllTicketsProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(ticketRepositoryProvider).watchAll();
});

// ticket management provider
final ticketManagementProvider =
    AsyncNotifierProvider<TicketManagementNotifier, String?>(
      TicketManagementNotifier.new,
    );

class TicketManagementNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    return null;
  }

  // create ticket - returns created document id
  Future<String> create({
    required String tenantId,
    required String unitId,
    required String propertyId,
    String? staffId,
    required String issueDescription,
    required List<String> imageUrls,
    required TicketPriority priority,
  }) async {
    state = const AsyncLoading();

    final id = await AsyncValue.guard(
      () => ref
          .read(ticketRepositoryProvider)
          .create( 
            tenantId: tenantId,
            unitId: unitId,
            propertyId: propertyId,
            staffId: staffId,
            issueDescription: issueDescription,
            imageUrls: imageUrls,
            priority: priority,
          ),
    ).then((v) => v as String);

    state = AsyncData(id);
    return id;
  }

  Future<void> assignStaff(String ticketId, String staffId) async {
    state = const AsyncLoading();
    await AsyncValue.guard(
      () => ref.read(ticketRepositoryProvider).assignStaff(ticketId, staffId),
    );
    state = const AsyncData(null);
  }

  Future<void> addImages(String ticketId, List<String> urls) async {
    state = const AsyncLoading();
    await AsyncValue.guard(
      () => ref.read(ticketRepositoryProvider).addImages(ticketId, urls),
    );
    state = const AsyncData(null);
  }

  Future<void> resolve(String ticketId, {DateTime? resolvedAt}) async {
    state = const AsyncLoading();
    await AsyncValue.guard(
      () => ref
          .read(ticketRepositoryProvider)
          .resolve(ticketId, resolvedAt: resolvedAt),
    );
    state = const AsyncData(null);
  }
}
