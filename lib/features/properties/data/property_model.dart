import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_model.freezed.dart';
part 'property_model.g.dart';

enum PropertyType {
  apartment,
  selfCon,
  commercial,
  house,
  shortLet;

  static PropertyType fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => PropertyType.apartment,
  );
}

enum RentPeriod {
  yearly,
  monthly,
  weekly,
  nightly;

  static RentPeriod fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => RentPeriod.yearly,
  );
}

@freezed
abstract class PropertyModel with _$PropertyModel {
  const factory PropertyModel({
    required String id,
    required String title,
    required String description,
    required String address,
    required String city,
    required String state,
    required PropertyType propertyType,
    required RentPeriod rentPeriod,
    required List<String> amenities,
    required List<String> imageUrls,
    required bool isFurnished,
    required bool isPublished,
    required int totalUnits, // maintained by cloud function
    required int availableUnit, // maintained by cloud function
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PropertyModel;

  factory PropertyModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return PropertyModel(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      address: data['address'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      propertyType: PropertyType.fromString(
        (data['property_type'] as String) ,
      ),
      rentPeriod: RentPeriod.fromString(
        data['rent_period'] as String,
      ),
      amenities: List<String>.from(data['amenities'] ?? const []),
      imageUrls: List<String>.from(data['image_urls'] ?? const []),
      isFurnished: data['is_furnished'] as bool? ?? false,
      isPublished: data['is_published'] as bool? ?? false,
      totalUnits: (data['total_units'] as num?)?.toInt() ?? 0,
      availableUnit: (data['available_units'] as num?)?.toInt() ?? 0,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyModelFromJson(json);
}
