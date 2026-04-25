// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PropertyModel _$PropertyModelFromJson(Map<String, dynamic> json) {
  return _PropertyModel.fromJson(json);
}

/// @nodoc
mixin _$PropertyModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get propertyType => throw _privateConstructorUsedError;
  List<String> get amenities => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  bool get isFurnished => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;
  int get totalUnits =>
      throw _privateConstructorUsedError; // maintained by cloud function
  int get availableUnit =>
      throw _privateConstructorUsedError; // maintained by cloud function
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PropertyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyModelCopyWith<PropertyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyModelCopyWith<$Res> {
  factory $PropertyModelCopyWith(
    PropertyModel value,
    $Res Function(PropertyModel) then,
  ) = _$PropertyModelCopyWithImpl<$Res, PropertyModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String address,
    String city,
    String state,
    String propertyType,
    List<String> amenities,
    List<String> imageUrls,
    bool isFurnished,
    bool isPublished,
    int totalUnits,
    int availableUnit,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PropertyModelCopyWithImpl<$Res, $Val extends PropertyModel>
    implements $PropertyModelCopyWith<$Res> {
  _$PropertyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? propertyType = null,
    Object? amenities = null,
    Object? imageUrls = null,
    Object? isFurnished = null,
    Object? isPublished = null,
    Object? totalUnits = null,
    Object? availableUnit = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            propertyType: null == propertyType
                ? _value.propertyType
                : propertyType // ignore: cast_nullable_to_non_nullable
                      as String,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isFurnished: null == isFurnished
                ? _value.isFurnished
                : isFurnished // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPublished: null == isPublished
                ? _value.isPublished
                : isPublished // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalUnits: null == totalUnits
                ? _value.totalUnits
                : totalUnits // ignore: cast_nullable_to_non_nullable
                      as int,
            availableUnit: null == availableUnit
                ? _value.availableUnit
                : availableUnit // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$PropertyModelImplCopyWith<$Res>
    implements $PropertyModelCopyWith<$Res> {
  factory _$$PropertyModelImplCopyWith(
    _$PropertyModelImpl value,
    $Res Function(_$PropertyModelImpl) then,
  ) = __$$PropertyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String address,
    String city,
    String state,
    String propertyType,
    List<String> amenities,
    List<String> imageUrls,
    bool isFurnished,
    bool isPublished,
    int totalUnits,
    int availableUnit,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PropertyModelImplCopyWithImpl<$Res>
    extends _$PropertyModelCopyWithImpl<$Res, _$PropertyModelImpl>
    implements _$$PropertyModelImplCopyWith<$Res> {
  __$$PropertyModelImplCopyWithImpl(
    _$PropertyModelImpl _value,
    $Res Function(_$PropertyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? propertyType = null,
    Object? amenities = null,
    Object? imageUrls = null,
    Object? isFurnished = null,
    Object? isPublished = null,
    Object? totalUnits = null,
    Object? availableUnit = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PropertyModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        propertyType: null == propertyType
            ? _value.propertyType
            : propertyType // ignore: cast_nullable_to_non_nullable
                  as String,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isFurnished: null == isFurnished
            ? _value.isFurnished
            : isFurnished // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPublished: null == isPublished
            ? _value.isPublished
            : isPublished // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalUnits: null == totalUnits
            ? _value.totalUnits
            : totalUnits // ignore: cast_nullable_to_non_nullable
                  as int,
        availableUnit: null == availableUnit
            ? _value.availableUnit
            : availableUnit // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$PropertyModelImpl implements _PropertyModel {
  const _$PropertyModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.propertyType,
    required final List<String> amenities,
    required final List<String> imageUrls,
    required this.isFurnished,
    required this.isPublished,
    required this.totalUnits,
    required this.availableUnit,
    required this.createdAt,
    required this.updatedAt,
  }) : _amenities = amenities,
       _imageUrls = imageUrls;

  factory _$PropertyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PropertyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String address;
  @override
  final String city;
  @override
  final String state;
  @override
  final String propertyType;
  final List<String> _amenities;
  @override
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final bool isFurnished;
  @override
  final bool isPublished;
  @override
  final int totalUnits;
  // maintained by cloud function
  @override
  final int availableUnit;
  // maintained by cloud function
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PropertyModel(id: $id, title: $title, description: $description, address: $address, city: $city, state: $state, propertyType: $propertyType, amenities: $amenities, imageUrls: $imageUrls, isFurnished: $isFurnished, isPublished: $isPublished, totalUnits: $totalUnits, availableUnit: $availableUnit, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.propertyType, propertyType) ||
                other.propertyType == propertyType) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.isFurnished, isFurnished) ||
                other.isFurnished == isFurnished) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.totalUnits, totalUnits) ||
                other.totalUnits == totalUnits) &&
            (identical(other.availableUnit, availableUnit) ||
                other.availableUnit == availableUnit) &&
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
    title,
    description,
    address,
    city,
    state,
    propertyType,
    const DeepCollectionEquality().hash(_amenities),
    const DeepCollectionEquality().hash(_imageUrls),
    isFurnished,
    isPublished,
    totalUnits,
    availableUnit,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PropertyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyModelImplCopyWith<_$PropertyModelImpl> get copyWith =>
      __$$PropertyModelImplCopyWithImpl<_$PropertyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertyModelImplToJson(this);
  }
}

abstract class _PropertyModel implements PropertyModel {
  const factory _PropertyModel({
    required final String id,
    required final String title,
    required final String description,
    required final String address,
    required final String city,
    required final String state,
    required final String propertyType,
    required final List<String> amenities,
    required final List<String> imageUrls,
    required final bool isFurnished,
    required final bool isPublished,
    required final int totalUnits,
    required final int availableUnit,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$PropertyModelImpl;

  factory _PropertyModel.fromJson(Map<String, dynamic> json) =
      _$PropertyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get address;
  @override
  String get city;
  @override
  String get state;
  @override
  String get propertyType;
  @override
  List<String> get amenities;
  @override
  List<String> get imageUrls;
  @override
  bool get isFurnished;
  @override
  bool get isPublished;
  @override
  int get totalUnits; // maintained by cloud function
  @override
  int get availableUnit; // maintained by cloud function
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PropertyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyModelImplCopyWith<_$PropertyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
