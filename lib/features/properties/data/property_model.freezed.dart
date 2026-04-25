// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PropertyModel {

 String get id; String get title; String get description; String get address; String get city; String get state; String get propertyType; List<String> get amenities; List<String> get imageUrls; bool get isFurnished; bool get isPublished; int get totalUnits;// maintained by cloud function
 int get availableUnit;// maintained by cloud function
 DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PropertyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyModelCopyWith<PropertyModel> get copyWith => _$PropertyModelCopyWithImpl<PropertyModel>(this as PropertyModel, _$identity);

  /// Serializes this PropertyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PropertyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.isFurnished, isFurnished) || other.isFurnished == isFurnished)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.availableUnit, availableUnit) || other.availableUnit == availableUnit)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,address,city,state,propertyType,const DeepCollectionEquality().hash(amenities),const DeepCollectionEquality().hash(imageUrls),isFurnished,isPublished,totalUnits,availableUnit,createdAt,updatedAt);

@override
String toString() {
  return 'PropertyModel(id: $id, title: $title, description: $description, address: $address, city: $city, state: $state, propertyType: $propertyType, amenities: $amenities, imageUrls: $imageUrls, isFurnished: $isFurnished, isPublished: $isPublished, totalUnits: $totalUnits, availableUnit: $availableUnit, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PropertyModelCopyWith<$Res>  {
  factory $PropertyModelCopyWith(PropertyModel value, $Res Function(PropertyModel) _then) = _$PropertyModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String address, String city, String state, String propertyType, List<String> amenities, List<String> imageUrls, bool isFurnished, bool isPublished, int totalUnits, int availableUnit, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PropertyModelCopyWithImpl<$Res>
    implements $PropertyModelCopyWith<$Res> {
  _$PropertyModelCopyWithImpl(this._self, this._then);

  final PropertyModel _self;
  final $Res Function(PropertyModel) _then;

/// Create a copy of PropertyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? address = null,Object? city = null,Object? state = null,Object? propertyType = null,Object? amenities = null,Object? imageUrls = null,Object? isFurnished = null,Object? isPublished = null,Object? totalUnits = null,Object? availableUnit = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isFurnished: null == isFurnished ? _self.isFurnished : isFurnished // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,availableUnit: null == availableUnit ? _self.availableUnit : availableUnit // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PropertyModel].
extension PropertyModelPatterns on PropertyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PropertyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PropertyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PropertyModel value)  $default,){
final _that = this;
switch (_that) {
case _PropertyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PropertyModel value)?  $default,){
final _that = this;
switch (_that) {
case _PropertyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String address,  String city,  String state,  String propertyType,  List<String> amenities,  List<String> imageUrls,  bool isFurnished,  bool isPublished,  int totalUnits,  int availableUnit,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PropertyModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.address,_that.city,_that.state,_that.propertyType,_that.amenities,_that.imageUrls,_that.isFurnished,_that.isPublished,_that.totalUnits,_that.availableUnit,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String address,  String city,  String state,  String propertyType,  List<String> amenities,  List<String> imageUrls,  bool isFurnished,  bool isPublished,  int totalUnits,  int availableUnit,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PropertyModel():
return $default(_that.id,_that.title,_that.description,_that.address,_that.city,_that.state,_that.propertyType,_that.amenities,_that.imageUrls,_that.isFurnished,_that.isPublished,_that.totalUnits,_that.availableUnit,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String address,  String city,  String state,  String propertyType,  List<String> amenities,  List<String> imageUrls,  bool isFurnished,  bool isPublished,  int totalUnits,  int availableUnit,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PropertyModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.address,_that.city,_that.state,_that.propertyType,_that.amenities,_that.imageUrls,_that.isFurnished,_that.isPublished,_that.totalUnits,_that.availableUnit,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PropertyModel implements PropertyModel {
  const _PropertyModel({required this.id, required this.title, required this.description, required this.address, required this.city, required this.state, required this.propertyType, required final  List<String> amenities, required final  List<String> imageUrls, required this.isFurnished, required this.isPublished, required this.totalUnits, required this.availableUnit, required this.createdAt, required this.updatedAt}): _amenities = amenities,_imageUrls = imageUrls;
  factory _PropertyModel.fromJson(Map<String, dynamic> json) => _$PropertyModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String address;
@override final  String city;
@override final  String state;
@override final  String propertyType;
 final  List<String> _amenities;
@override List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

 final  List<String> _imageUrls;
@override List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  bool isFurnished;
@override final  bool isPublished;
@override final  int totalUnits;
// maintained by cloud function
@override final  int availableUnit;
// maintained by cloud function
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PropertyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PropertyModelCopyWith<_PropertyModel> get copyWith => __$PropertyModelCopyWithImpl<_PropertyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PropertyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PropertyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.isFurnished, isFurnished) || other.isFurnished == isFurnished)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.availableUnit, availableUnit) || other.availableUnit == availableUnit)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,address,city,state,propertyType,const DeepCollectionEquality().hash(_amenities),const DeepCollectionEquality().hash(_imageUrls),isFurnished,isPublished,totalUnits,availableUnit,createdAt,updatedAt);

@override
String toString() {
  return 'PropertyModel(id: $id, title: $title, description: $description, address: $address, city: $city, state: $state, propertyType: $propertyType, amenities: $amenities, imageUrls: $imageUrls, isFurnished: $isFurnished, isPublished: $isPublished, totalUnits: $totalUnits, availableUnit: $availableUnit, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PropertyModelCopyWith<$Res> implements $PropertyModelCopyWith<$Res> {
  factory _$PropertyModelCopyWith(_PropertyModel value, $Res Function(_PropertyModel) _then) = __$PropertyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String address, String city, String state, String propertyType, List<String> amenities, List<String> imageUrls, bool isFurnished, bool isPublished, int totalUnits, int availableUnit, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PropertyModelCopyWithImpl<$Res>
    implements _$PropertyModelCopyWith<$Res> {
  __$PropertyModelCopyWithImpl(this._self, this._then);

  final _PropertyModel _self;
  final $Res Function(_PropertyModel) _then;

/// Create a copy of PropertyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? address = null,Object? city = null,Object? state = null,Object? propertyType = null,Object? amenities = null,Object? imageUrls = null,Object? isFurnished = null,Object? isPublished = null,Object? totalUnits = null,Object? availableUnit = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PropertyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isFurnished: null == isFurnished ? _self.isFurnished : isFurnished // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,availableUnit: null == availableUnit ? _self.availableUnit : availableUnit // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
