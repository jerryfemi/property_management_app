// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnitModel {

 String get id; String get propertyId; String get unitNumber; int get bedrooms; int get bathrooms; double get baseRent; List<String> get amenities; UnitStatus get unitStatus; String? get currentTenantId; String? get floorPlanUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of UnitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitModelCopyWith<UnitModel> get copyWith => _$UnitModelCopyWithImpl<UnitModel>(this as UnitModel, _$identity);

  /// Serializes this UnitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.baseRent, baseRent) || other.baseRent == baseRent)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&(identical(other.unitStatus, unitStatus) || other.unitStatus == unitStatus)&&(identical(other.currentTenantId, currentTenantId) || other.currentTenantId == currentTenantId)&&(identical(other.floorPlanUrl, floorPlanUrl) || other.floorPlanUrl == floorPlanUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,unitNumber,bedrooms,bathrooms,baseRent,const DeepCollectionEquality().hash(amenities),unitStatus,currentTenantId,floorPlanUrl,createdAt,updatedAt);

@override
String toString() {
  return 'UnitModel(id: $id, propertyId: $propertyId, unitNumber: $unitNumber, bedrooms: $bedrooms, bathrooms: $bathrooms, baseRent: $baseRent, amenities: $amenities, unitStatus: $unitStatus, currentTenantId: $currentTenantId, floorPlanUrl: $floorPlanUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UnitModelCopyWith<$Res>  {
  factory $UnitModelCopyWith(UnitModel value, $Res Function(UnitModel) _then) = _$UnitModelCopyWithImpl;
@useResult
$Res call({
 String id, String propertyId, String unitNumber, int bedrooms, int bathrooms, double baseRent, List<String> amenities, UnitStatus unitStatus, String? currentTenantId, String? floorPlanUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$UnitModelCopyWithImpl<$Res>
    implements $UnitModelCopyWith<$Res> {
  _$UnitModelCopyWithImpl(this._self, this._then);

  final UnitModel _self;
  final $Res Function(UnitModel) _then;

/// Create a copy of UnitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? propertyId = null,Object? unitNumber = null,Object? bedrooms = null,Object? bathrooms = null,Object? baseRent = null,Object? amenities = null,Object? unitStatus = null,Object? currentTenantId = freezed,Object? floorPlanUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,baseRent: null == baseRent ? _self.baseRent : baseRent // ignore: cast_nullable_to_non_nullable
as double,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,unitStatus: null == unitStatus ? _self.unitStatus : unitStatus // ignore: cast_nullable_to_non_nullable
as UnitStatus,currentTenantId: freezed == currentTenantId ? _self.currentTenantId : currentTenantId // ignore: cast_nullable_to_non_nullable
as String?,floorPlanUrl: freezed == floorPlanUrl ? _self.floorPlanUrl : floorPlanUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitModel].
extension UnitModelPatterns on UnitModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitModel value)  $default,){
final _that = this;
switch (_that) {
case _UnitModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitModel value)?  $default,){
final _that = this;
switch (_that) {
case _UnitModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String propertyId,  String unitNumber,  int bedrooms,  int bathrooms,  double baseRent,  List<String> amenities,  UnitStatus unitStatus,  String? currentTenantId,  String? floorPlanUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitModel() when $default != null:
return $default(_that.id,_that.propertyId,_that.unitNumber,_that.bedrooms,_that.bathrooms,_that.baseRent,_that.amenities,_that.unitStatus,_that.currentTenantId,_that.floorPlanUrl,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String propertyId,  String unitNumber,  int bedrooms,  int bathrooms,  double baseRent,  List<String> amenities,  UnitStatus unitStatus,  String? currentTenantId,  String? floorPlanUrl,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UnitModel():
return $default(_that.id,_that.propertyId,_that.unitNumber,_that.bedrooms,_that.bathrooms,_that.baseRent,_that.amenities,_that.unitStatus,_that.currentTenantId,_that.floorPlanUrl,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String propertyId,  String unitNumber,  int bedrooms,  int bathrooms,  double baseRent,  List<String> amenities,  UnitStatus unitStatus,  String? currentTenantId,  String? floorPlanUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UnitModel() when $default != null:
return $default(_that.id,_that.propertyId,_that.unitNumber,_that.bedrooms,_that.bathrooms,_that.baseRent,_that.amenities,_that.unitStatus,_that.currentTenantId,_that.floorPlanUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitModel implements UnitModel {
  const _UnitModel({required this.id, required this.propertyId, required this.unitNumber, required this.bedrooms, required this.bathrooms, required this.baseRent, required final  List<String> amenities, required this.unitStatus, this.currentTenantId, this.floorPlanUrl, required this.createdAt, required this.updatedAt}): _amenities = amenities;
  factory _UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);

@override final  String id;
@override final  String propertyId;
@override final  String unitNumber;
@override final  int bedrooms;
@override final  int bathrooms;
@override final  double baseRent;
 final  List<String> _amenities;
@override List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

@override final  UnitStatus unitStatus;
@override final  String? currentTenantId;
@override final  String? floorPlanUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of UnitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitModelCopyWith<_UnitModel> get copyWith => __$UnitModelCopyWithImpl<_UnitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.baseRent, baseRent) || other.baseRent == baseRent)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&(identical(other.unitStatus, unitStatus) || other.unitStatus == unitStatus)&&(identical(other.currentTenantId, currentTenantId) || other.currentTenantId == currentTenantId)&&(identical(other.floorPlanUrl, floorPlanUrl) || other.floorPlanUrl == floorPlanUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,propertyId,unitNumber,bedrooms,bathrooms,baseRent,const DeepCollectionEquality().hash(_amenities),unitStatus,currentTenantId,floorPlanUrl,createdAt,updatedAt);

@override
String toString() {
  return 'UnitModel(id: $id, propertyId: $propertyId, unitNumber: $unitNumber, bedrooms: $bedrooms, bathrooms: $bathrooms, baseRent: $baseRent, amenities: $amenities, unitStatus: $unitStatus, currentTenantId: $currentTenantId, floorPlanUrl: $floorPlanUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UnitModelCopyWith<$Res> implements $UnitModelCopyWith<$Res> {
  factory _$UnitModelCopyWith(_UnitModel value, $Res Function(_UnitModel) _then) = __$UnitModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String propertyId, String unitNumber, int bedrooms, int bathrooms, double baseRent, List<String> amenities, UnitStatus unitStatus, String? currentTenantId, String? floorPlanUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$UnitModelCopyWithImpl<$Res>
    implements _$UnitModelCopyWith<$Res> {
  __$UnitModelCopyWithImpl(this._self, this._then);

  final _UnitModel _self;
  final $Res Function(_UnitModel) _then;

/// Create a copy of UnitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? propertyId = null,Object? unitNumber = null,Object? bedrooms = null,Object? bathrooms = null,Object? baseRent = null,Object? amenities = null,Object? unitStatus = null,Object? currentTenantId = freezed,Object? floorPlanUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UnitModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as String,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,baseRent: null == baseRent ? _self.baseRent : baseRent // ignore: cast_nullable_to_non_nullable
as double,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,unitStatus: null == unitStatus ? _self.unitStatus : unitStatus // ignore: cast_nullable_to_non_nullable
as UnitStatus,currentTenantId: freezed == currentTenantId ? _self.currentTenantId : currentTenantId // ignore: cast_nullable_to_non_nullable
as String?,floorPlanUrl: freezed == floorPlanUrl ? _self.floorPlanUrl : floorPlanUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
