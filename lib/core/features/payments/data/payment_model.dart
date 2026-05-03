
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

enum PaymentStatus { pending, cleared, failed;
  static PaymentStatus fromString(String v) =>
    values.firstWhere((e) => e.name == v, orElse: () => PaymentStatus.pending);
}



@freezed
 abstract class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id,
    required String tenantId,
    required String leaseId,
    required double amountPaid,
    required PaymentStatus status,
    required String paymentMethod,
    required String referenceId,     // Paystack/Flutterwave txn ID
    required DateTime periodStart,
    required DateTime periodEnd,
    required DateTime dueDate,
    DateTime? datePaid,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PaymentModel;

  factory PaymentModel.fromFirestore(DocumentSnapshot<Map<String,dynamic>> doc) {
    final data = doc.data()!;
    return PaymentModel(
      id:            doc.id,
      tenantId:      data['tenant_id'] as String,
      leaseId:       data['lease_id'] as String,
      amountPaid:    (data['amount_paid'] as num).toDouble(),
      status:        PaymentStatus.fromString(data['status'] as String),
      paymentMethod: data['payment_method'] as String,
      referenceId:   data['reference_id'] as String,
      periodStart:   (data['period_start'] as Timestamp).toDate(),
      periodEnd:     (data['period_end'] as Timestamp).toDate(),
      dueDate:       (data['due_date'] as Timestamp).toDate(),
      datePaid:      data['date_paid'] != null ? (data['date_paid'] as Timestamp).toDate() : null,
      createdAt:     (data['created_at'] as Timestamp).toDate(),
      updatedAt:     (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory PaymentModel.fromJson(Map<String,dynamic> json) => _$PaymentModelFromJson(json);
}
