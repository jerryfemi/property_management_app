// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) {
  return _UnitModel.fromJson(json);
}

/// @nodoc
mixin _$UnitModel {
  String get id => throw _privateConstructorUsedError;
  String get propertyId => throw _privateConstructorUsedError;
  String get unitName => throw _privateConstructorUsedError;
  int get bedrooms => throw _privateConstructorUsedError;
  int get bathrooms => throw _privateConstructorUsedError;
  double get baseRent => throw _privateConstructorUsedError;
  List<String> get amenities => throw _privateConstructorUsedError;
  UnitStatus get unitStatus => throw _privateConstructorUsedError;
  String? get currentTenantId => throw _privateConstructorUsedError;
  String? get floorPlanUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UnitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UnitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnitModelCopyWith<UnitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitModelCopyWith<$Res> {
  factory $UnitModelCopyWith(UnitModel value, $Res Function(UnitModel) then) =
      _$UnitModelCopyWithImpl<$Res, UnitModel>;
  @useResult
  $Res call({
    String id,
    String propertyId,
    String unitName,
    int bedrooms,
    int bathrooms,
    double baseRent,
    List<String> amenities,
    UnitStatus unitStatus,
    String? currentTenantId,
    String? floorPlanUrl,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$UnitModelCopyWithImpl<$Res, $Val extends UnitModel>
    implements $UnitModelCopyWith<$Res> {
  _$UnitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? propertyId = null,
    Object? unitName = null,
    Object? bedrooms = null,
    Object? bathrooms = null,
    Object? baseRent = null,
    Object? amenities = null,
    Object? unitStatus = null,
    Object? currentTenantId = freezed,
    Object? floorPlanUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            propertyId: null == propertyId
                ? _value.propertyId
                : propertyId // ignore: cast_nullable_to_non_nullable
                      as String,
            unitName: null == unitName
                ? _value.unitName
                : unitName // ignore: cast_nullable_to_non_nullable
                      as String,
            bedrooms: null == bedrooms
                ? _value.bedrooms
                : bedrooms // ignore: cast_nullable_to_non_nullable
                      as int,
            bathrooms: null == bathrooms
                ? _value.bathrooms
                : bathrooms // ignore: cast_nullable_to_non_nullable
                      as int,
            baseRent: null == baseRent
                ? _value.baseRent
                : baseRent // ignore: cast_nullable_to_non_nullable
                      as double,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            unitStatus: null == unitStatus
                ? _value.unitStatus
                : unitStatus // ignore: cast_nullable_to_non_nullable
                      as UnitStatus,
            currentTenantId: freezed == currentTenantId
                ? _value.currentTenantId
                : currentTenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            floorPlanUrl: freezed == floorPlanUrl
                ? _value.floorPlanUrl
                : floorPlanUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UnitModelImplCopyWith<$Res>
    implements $UnitModelCopyWith<$Res> {
  factory _$$UnitModelImplCopyWith(
    _$UnitModelImpl value,
    $Res Function(_$UnitModelImpl) then,
  ) = __$$UnitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String propertyId,
    String unitName,
    int bedrooms,
    int bathrooms,
    double baseRent,
    List<String> amenities,
    UnitStatus unitStatus,
    String? currentTenantId,
    String? floorPlanUrl,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$UnitModelImplCopyWithImpl<$Res>
    extends _$UnitModelCopyWithImpl<$Res, _$UnitModelImpl>
    implements _$$UnitModelImplCopyWith<$Res> {
  __$$UnitModelImplCopyWithImpl(
    _$UnitModelImpl _value,
    $Res Function(_$UnitModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UnitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? propertyId = null,
    Object? unitName = null,
    Object? bedrooms = null,
    Object? bathrooms = null,
    Object? baseRent = null,
    Object? amenities = null,
    Object? unitStatus = null,
    Object? currentTenantId = freezed,
    Object? floorPlanUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UnitModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        propertyId: null == propertyId
            ? _value.propertyId
            : propertyId // ignore: cast_nullable_to_non_nullable
                  as String,
        unitName: null == unitName
            ? _value.unitName
            : unitName // ignore: cast_nullable_to_non_nullable
                  as String,
        bedrooms: null == bedrooms
            ? _value.bedrooms
            : bedrooms // ignore: cast_nullable_to_non_nullable
                  as int,
        bathrooms: null == bathrooms
            ? _value.bathrooms
            : bathrooms // ignore: cast_nullable_to_non_nullable
                  as int,
        baseRent: null == baseRent
            ? _value.baseRent
            : baseRent // ignore: cast_nullable_to_non_nullable
                  as double,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        unitStatus: null == unitStatus
            ? _value.unitStatus
            : unitStatus // ignore: cast_nullable_to_non_nullable
                  as UnitStatus,
        currentTenantId: freezed == currentTenantId
            ? _value.currentTenantId
            : currentTenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        floorPlanUrl: freezed == floorPlanUrl
            ? _value.floorPlanUrl
            : floorPlanUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitModelImpl implements _UnitModel {
  const _$UnitModelImpl({
    required this.id,
    required this.propertyId,
    required this.unitName,
    required this.bedrooms,
    required this.bathrooms,
    required this.baseRent,
    required final List<String> amenities,
    required this.unitStatus,
    this.currentTenantId,
    this.floorPlanUrl,
    required this.createdAt,
    required this.updatedAt,
  }) : _amenities = amenities;

  factory _$UnitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitModelImplFromJson(json);

  @override
  final String id;
  @override
  final String propertyId;
  @override
  final String unitName;
  @override
  final int bedrooms;
  @override
  final int bathrooms;
  @override
  final double baseRent;
  final List<String> _amenities;
  @override
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  @override
  final UnitStatus unitStatus;
  @override
  final String? currentTenantId;
  @override
  final String? floorPlanUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UnitModel(id: $id, propertyId: $propertyId, unitName: $unitName, bedrooms: $bedrooms, bathrooms: $bathrooms, baseRent: $baseRent, amenities: $amenities, unitStatus: $unitStatus, currentTenantId: $currentTenantId, floorPlanUrl: $floorPlanUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.propertyId, propertyId) ||
                other.propertyId == propertyId) &&
            (identical(other.unitName, unitName) ||
                other.unitName == unitName) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            (identical(other.baseRent, baseRent) ||
                other.baseRent == baseRent) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            (identical(other.unitStatus, unitStatus) ||
                other.unitStatus == unitStatus) &&
            (identical(other.currentTenantId, currentTenantId) ||
                other.currentTenantId == currentTenantId) &&
            (identical(other.floorPlanUrl, floorPlanUrl) ||
                other.floorPlanUrl == floorPlanUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    propertyId,
    unitName,
    bedrooms,
    bathrooms,
    baseRent,
    const DeepCollectionEquality().hash(_amenities),
    unitStatus,
    currentTenantId,
    floorPlanUrl,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UnitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitModelImplCopyWith<_$UnitModelImpl> get copyWith =>
      __$$UnitModelImplCopyWithImpl<_$UnitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitModelImplToJson(this);
  }
}

abstract class _UnitModel implements UnitModel {
  const factory _UnitModel({
    required final String id,
    required final String propertyId,
    required final String unitName,
    required final int bedrooms,
    required final int bathrooms,
    required final double baseRent,
    required final List<String> amenities,
    required final UnitStatus unitStatus,
    final String? currentTenantId,
    final String? floorPlanUrl,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$UnitModelImpl;

  factory _UnitModel.fromJson(Map<String, dynamic> json) =
      _$UnitModelImpl.fromJson;

  @override
  String get id;
  @override
  String get propertyId;
  @override
  String get unitName;
  @override
  int get bedrooms;
  @override
  int get bathrooms;
  @override
  double get baseRent;
  @override
  List<String> get amenities;
  @override
  UnitStatus get unitStatus;
  @override
  String? get currentTenantId;
  @override
  String? get floorPlanUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UnitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnitModelImplCopyWith<_$UnitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
