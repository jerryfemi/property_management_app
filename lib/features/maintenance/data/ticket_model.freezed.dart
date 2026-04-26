// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketModel {

 String get id; String get tenantId; String get unitId; String get propertyId; String? get staffId;// Nullable — assigned after creation
 String get issueDescription; List<String> get imageUrls; TicketPriority get priority; TicketStatus get status; DateTime get createdAt; DateTime get updatedAt; DateTime? get resolvedAt;
/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketModelCopyWith<TicketModel> get copyWith => _$TicketModelCopyWithImpl<TicketModel>(this as TicketModel, _$identity);

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.issueDescription, issueDescription) || other.issueDescription == issueDescription)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,unitId,propertyId,staffId,issueDescription,const DeepCollectionEquality().hash(imageUrls),priority,status,createdAt,updatedAt,resolvedAt);

@override
String toString() {
  return 'TicketModel(id: $id, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, staffId: $staffId, issueDescription: $issueDescription, imageUrls: $imageUrls, priority: $priority, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $TicketModelCopyWith<$Res>  {
  factory $TicketModelCopyWith(TicketModel value, $Res Function(TicketModel) _then) = _$TicketModelCopyWithImpl;
@useResult
$Res call({
 String id, String tenantId, String unitId, String propertyId, String? staffId, String issueDescription, List<String> imageUrls, TicketPriority priority, TicketStatus status, DateTime createdAt, DateTime updatedAt, DateTime? resolvedAt
});




}
/// @nodoc
class _$TicketModelCopyWithImpl<$Res>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._self, this._then);

  final TicketModel _self;
  final $Res Function(TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? unitId = null,Object? propertyId = null,Object? staffId = freezed,Object? issueDescription = null,Object? imageUrls = null,Object? priority = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,issueDescription: null == issueDescription ? _self.issueDescription : issueDescription // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketModel].
extension TicketModelPatterns on TicketModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tenantId,  String unitId,  String propertyId,  String? staffId,  String issueDescription,  List<String> imageUrls,  TicketPriority priority,  TicketStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.staffId,_that.issueDescription,_that.imageUrls,_that.priority,_that.status,_that.createdAt,_that.updatedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tenantId,  String unitId,  String propertyId,  String? staffId,  String issueDescription,  List<String> imageUrls,  TicketPriority priority,  TicketStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.staffId,_that.issueDescription,_that.imageUrls,_that.priority,_that.status,_that.createdAt,_that.updatedAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tenantId,  String unitId,  String propertyId,  String? staffId,  String issueDescription,  List<String> imageUrls,  TicketPriority priority,  TicketStatus status,  DateTime createdAt,  DateTime updatedAt,  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.staffId,_that.issueDescription,_that.imageUrls,_that.priority,_that.status,_that.createdAt,_that.updatedAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketModel implements TicketModel {
  const _TicketModel({required this.id, required this.tenantId, required this.unitId, required this.propertyId, this.staffId, required this.issueDescription, required final  List<String> imageUrls, required this.priority, required this.status, required this.createdAt, required this.updatedAt, this.resolvedAt}): _imageUrls = imageUrls;
  factory _TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

@override final  String id;
@override final  String tenantId;
@override final  String unitId;
@override final  String propertyId;
@override final  String? staffId;
// Nullable — assigned after creation
@override final  String issueDescription;
 final  List<String> _imageUrls;
@override List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  TicketPriority priority;
@override final  TicketStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? resolvedAt;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketModelCopyWith<_TicketModel> get copyWith => __$TicketModelCopyWithImpl<_TicketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.issueDescription, issueDescription) || other.issueDescription == issueDescription)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,unitId,propertyId,staffId,issueDescription,const DeepCollectionEquality().hash(_imageUrls),priority,status,createdAt,updatedAt,resolvedAt);

@override
String toString() {
  return 'TicketModel(id: $id, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, staffId: $staffId, issueDescription: $issueDescription, imageUrls: $imageUrls, priority: $priority, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketModelCopyWith<$Res> implements $TicketModelCopyWith<$Res> {
  factory _$TicketModelCopyWith(_TicketModel value, $Res Function(_TicketModel) _then) = __$TicketModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tenantId, String unitId, String propertyId, String? staffId, String issueDescription, List<String> imageUrls, TicketPriority priority, TicketStatus status, DateTime createdAt, DateTime updatedAt, DateTime? resolvedAt
});




}
/// @nodoc
class __$TicketModelCopyWithImpl<$Res>
    implements _$TicketModelCopyWith<$Res> {
  __$TicketModelCopyWithImpl(this._self, this._then);

  final _TicketModel _self;
  final $Res Function(_TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? unitId = null,Object? propertyId = null,Object? staffId = freezed,Object? issueDescription = null,Object? imageUrls = null,Object? priority = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? resolvedAt = freezed,}) {
  return _then(_TicketModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as String?,issueDescription: null == issueDescription ? _self.issueDescription : issueDescription // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
