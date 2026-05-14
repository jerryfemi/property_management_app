import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'property_model.freezed.dart';
part 'property_model.g.dart';

@HiveType(typeId: 0)
enum PropertyType {
  @HiveField(0) apartment,
  @HiveField(1) selfCon,
  @HiveField(2) commercial,
  @HiveField(3) house,
  @HiveField(4) shortLet;

  static PropertyType fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => PropertyType.apartment,
  );
}

@HiveType(typeId: 1)
enum RentPeriod {
  @HiveField(0) yearly,
  @HiveField(1) monthly,
  @HiveField(2) weekly,
  @HiveField(3) nightly;

  static RentPeriod fromString(String value) => values.firstWhere(
    (e) => e.name == value,
    orElse: () => RentPeriod.yearly,
  );
}

@freezed
@HiveType(typeId: 2)
abstract class PropertyModel with _$PropertyModel {
  const factory PropertyModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required String address,
    @HiveField(4) required String city,
    @HiveField(5) required String state,
    @HiveField(6) required PropertyType propertyType,
    @HiveField(7) required RentPeriod rentPeriod,
    @HiveField(8) required List<String> amenities,
    @HiveField(9) required List<String> imageUrls,
    @HiveField(10) required bool isFurnished,
    @HiveField(11) required bool isPublished,
    @HiveField(12) required int totalUnits, // maintained by cloud function
    @HiveField(13) required int availableUnit, // maintained by cloud function
    @HiveField(14) required DateTime createdAt,
    @HiveField(15) required DateTime updatedAt,
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
