import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_model.freezed.dart';
part 'unit_model.g.dart';

enum UnitStatus {
  vacant,
  reserved,
  occupied,
  maintenance;

  static UnitStatus fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => UnitStatus.vacant,
  );

  String get label => name[0].toUpperCase() + name.substring(1);
  bool get isVacant => this == UnitStatus.vacant;
}

@freezed
class UnitModel with _$UnitModel {
  const factory UnitModel({
    required String id,
    required String propertyId,
    required String unitName,
    required int bedrooms,
    required int bathrooms,
    required double baseRent,
    required List<String> amenities,
    required UnitStatus unitStatus,
    String? currentTenantId,
    String? floorPlanUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UnitModel;

  factory UnitModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UnitModel(
      id: doc.id,
      propertyId: data['property_id'] as String,
      unitName: data['unit_name'] as String,
      bedrooms: (data['bedrooms'] as num).toInt(),
      bathrooms: (data['bathrooms'] as num).toInt(),
      baseRent: (data['base_rent'] as num).toDouble(),
      amenities: List<String>.from(data['amenities'] ?? const []),
      unitStatus: UnitStatus.fromString(data['unit_status'] as String),
      currentTenantId: data['current_tenant_id'] as String?,
      floorPlanUrl: data['floor_plan_url'] as String?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);
}

extension UnitGrouping on List<UnitModel> {
  Map<int, List<UnitModel>> groupByBedrooms() {
    final grouped = <int, List<UnitModel>>{};
    for (final unit in this) {
      grouped.putIfAbsent(unit.bedrooms, () => []).add(unit);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  double get minRent =>
      isEmpty ? 0 : map((u) => u.baseRent).reduce((a, b) => a < b ? a : b);
}
