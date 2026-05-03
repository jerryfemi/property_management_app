import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

enum TicketStatus {
  pending,
  inProgress,
  resolved;

  static TicketStatus fromString(String v) =>
      values.firstWhere((e) => e.name == v, orElse: () => TicketStatus.pending);
}

enum TicketPriority {
  low,
  medium,
  high;

  static TicketPriority fromString(String v) => values.firstWhere(
    (e) => e.name == v,
    orElse: () => TicketPriority.medium,
  );
}

@freezed
abstract class TicketModel with _$TicketModel {
  const factory TicketModel({
    required String id,
    required String tenantId,
    required String unitId,
    required String propertyId,
    String? staffId, // Nullable — assigned after creation
    required String issueDescription,
    required List<String> imageUrls,
    required TicketPriority priority,
    required TicketStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt, // Nullable
  }) = _TicketModel;

  factory TicketModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return TicketModel(
      id: doc.id,
      tenantId: data['tenant_id'] as String,
      unitId: data['unit_id'] as String,
      propertyId: data['property_id'] as String,
      staffId: data['staff_id'] as String?,
      issueDescription: data['issue_description'] as String,
      imageUrls: List<String>.from(data['image_urls'] ?? []),
      priority: TicketPriority.fromString(data['priority'] as String),
      status: TicketStatus.fromString(data['status'] as String),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
      resolvedAt: data['resolved_at'] != null
          ? (data['resolved_at'] as Timestamp).toDate()
          : null,
    );
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}
