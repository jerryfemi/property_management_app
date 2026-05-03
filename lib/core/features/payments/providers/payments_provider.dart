import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';

import 'package:pro_app/core/features/payments/data/payment_model.dart';
import 'package:pro_app/core/features/payments/data/payments_repository.dart';

// payment repo provider --DI
final paymentRepositoryProvider = Provider<PaymentsRepository>((ref) {
  return PaymentsRepository(FirebaseFirestore.instance);
});

// tenant's full payment history
final myPaymentsProvider = StreamProvider.autoDispose<List<PaymentModel>>((
  ref,
) {
  final uid = ref.watch(authStateProvider).value?.uid;
  if (uid == null) return Stream.value([]);

  return ref.watch(paymentRepositoryProvider).watchForTenant(uid);
});

// all payments for specific lease
final paymentsForLeaseProvider = StreamProvider.autoDispose
    .family<List<PaymentModel>, String>((ref, leaseId) {
      return ref.watch(paymentRepositoryProvider).watchForLease(leaseId);
    });

// admin see all
final allPaymentsProvider = StreamProvider.autoDispose<List<PaymentModel>>((
  ref,
) {
  return ref.watch(paymentRepositoryProvider).watchAll();
});

//
final pendingPaymentsProvider =
    Provider.autoDispose<AsyncValue<List<PaymentModel>>>((ref) {
      return ref
          .watch(allPaymentsProvider)
          .whenData(
            (payments) => payments
                .where((payment) => payment.status == PaymentStatus.pending)
                .toList(),
          );
    });

// single payment detail/ receipt screen
final paymentDetailProvider = FutureProvider.autoDispose
    .family<PaymentModel?, String>((ref, id) {
      return ref.watch(paymentRepositoryProvider).fetch(id);
    });
