// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lease_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaseModel {

 String get id; String get tenantId; String get unitId; String get propertyId; String get createdByAdminId;// audit trail
 RentPeriod get rentPeriod; LeaseStatus get status; double get monthlyRent; double get securityDeposit; double? get agreementFee; double? get agencyFee; double? get serviceCharge; int? get paymentDueDay;// 1-28 for recurring leases
 DateTime get startDate; DateTime get endDate; String? get contractUrl;// Firebase Storage PDF
 DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of LeaseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaseModelCopyWith<LeaseModel> get copyWith => _$LeaseModelCopyWithImpl<LeaseModel>(this as LeaseModel, _$identity);

  /// Serializes this LeaseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.createdByAdminId, createdByAdminId) || other.createdByAdminId == createdByAdminId)&&(identical(other.rentPeriod, rentPeriod) || other.rentPeriod == rentPeriod)&&(identical(other.status, status) || other.status == status)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.securityDeposit, securityDeposit) || other.securityDeposit == securityDeposit)&&(identical(other.agreementFee, agreementFee) || other.agreementFee == agreementFee)&&(identical(other.agencyFee, agencyFee) || other.agencyFee == agencyFee)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.paymentDueDay, paymentDueDay) || other.paymentDueDay == paymentDueDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.contractUrl, contractUrl) || other.contractUrl == contractUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,unitId,propertyId,createdByAdminId,rentPeriod,status,monthlyRent,securityDeposit,agreementFee,agencyFee,serviceCharge,paymentDueDay,startDate,endDate,contractUrl,createdAt,updatedAt);

@override
String toString() {
  return 'LeaseModel(id: $id, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, createdByAdminId: $createdByAdminId, rentPeriod: $rentPeriod, status: $status, monthlyRent: $monthlyRent, securityDeposit: $securityDeposit, agreementFee: $agreementFee, agencyFee: $agencyFee, serviceCharge: $serviceCharge, paymentDueDay: $paymentDueDay, startDate: $startDate, endDate: $endDate, contractUrl: $contractUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LeaseModelCopyWith<$Res>  {
  factory $LeaseModelCopyWith(LeaseModel value, $Res Function(LeaseModel) _then) = _$LeaseModelCopyWithImpl;
@useResult
$Res call({
 String id, String tenantId, String unitId, String propertyId, String createdByAdminId, RentPeriod rentPeriod, LeaseStatus status, double monthlyRent, double securityDeposit, double? agreementFee, double? agencyFee, double? serviceCharge, int? paymentDueDay, DateTime startDate, DateTime endDate, String? contractUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$LeaseModelCopyWithImpl<$Res>
    implements $LeaseModelCopyWith<$Res> {
  _$LeaseModelCopyWithImpl(this._self, this._then);

  final LeaseModel _self;
  final $Res Function(LeaseModel) _then;

/// Create a copy of LeaseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? unitId = null,Object? propertyId = null,Object? createdByAdminId = null,Object? rentPeriod = null,Object? status = null,Object? monthlyRent = null,Object? securityDeposit = null,Object? agreementFee = freezed,Object? agencyFee = freezed,Object? serviceCharge = freezed,Object? paymentDueDay = freezed,Object? startDate = null,Object? endDate = null,Object? contractUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,createdByAdminId: null == createdByAdminId ? _self.createdByAdminId : createdByAdminId // ignore: cast_nullable_to_non_nullable
as String,rentPeriod: null == rentPeriod ? _self.rentPeriod : rentPeriod // ignore: cast_nullable_to_non_nullable
as RentPeriod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LeaseStatus,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,securityDeposit: null == securityDeposit ? _self.securityDeposit : securityDeposit // ignore: cast_nullable_to_non_nullable
as double,agreementFee: freezed == agreementFee ? _self.agreementFee : agreementFee // ignore: cast_nullable_to_non_nullable
as double?,agencyFee: freezed == agencyFee ? _self.agencyFee : agencyFee // ignore: cast_nullable_to_non_nullable
as double?,serviceCharge: freezed == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double?,paymentDueDay: freezed == paymentDueDay ? _self.paymentDueDay : paymentDueDay // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,contractUrl: freezed == contractUrl ? _self.contractUrl : contractUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaseModel].
extension LeaseModelPatterns on LeaseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaseModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaseModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tenantId,  String unitId,  String propertyId,  String createdByAdminId,  RentPeriod rentPeriod,  LeaseStatus status,  double monthlyRent,  double securityDeposit,  double? agreementFee,  double? agencyFee,  double? serviceCharge,  int? paymentDueDay,  DateTime startDate,  DateTime endDate,  String? contractUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaseModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.createdByAdminId,_that.rentPeriod,_that.status,_that.monthlyRent,_that.securityDeposit,_that.agreementFee,_that.agencyFee,_that.serviceCharge,_that.paymentDueDay,_that.startDate,_that.endDate,_that.contractUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tenantId,  String unitId,  String propertyId,  String createdByAdminId,  RentPeriod rentPeriod,  LeaseStatus status,  double monthlyRent,  double securityDeposit,  double? agreementFee,  double? agencyFee,  double? serviceCharge,  int? paymentDueDay,  DateTime startDate,  DateTime endDate,  String? contractUrl,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LeaseModel():
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.createdByAdminId,_that.rentPeriod,_that.status,_that.monthlyRent,_that.securityDeposit,_that.agreementFee,_that.agencyFee,_that.serviceCharge,_that.paymentDueDay,_that.startDate,_that.endDate,_that.contractUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tenantId,  String unitId,  String propertyId,  String createdByAdminId,  RentPeriod rentPeriod,  LeaseStatus status,  double monthlyRent,  double securityDeposit,  double? agreementFee,  double? agencyFee,  double? serviceCharge,  int? paymentDueDay,  DateTime startDate,  DateTime endDate,  String? contractUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LeaseModel() when $default != null:
return $default(_that.id,_that.tenantId,_that.unitId,_that.propertyId,_that.createdByAdminId,_that.rentPeriod,_that.status,_that.monthlyRent,_that.securityDeposit,_that.agreementFee,_that.agencyFee,_that.serviceCharge,_that.paymentDueDay,_that.startDate,_that.endDate,_that.contractUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaseModel extends LeaseModel {
  const _LeaseModel({required this.id, required this.tenantId, required this.unitId, required this.propertyId, required this.createdByAdminId, required this.rentPeriod, required this.status, required this.monthlyRent, required this.securityDeposit, this.agreementFee, this.agencyFee, this.serviceCharge, this.paymentDueDay, required this.startDate, required this.endDate, this.contractUrl, required this.createdAt, required this.updatedAt}): super._();
  factory _LeaseModel.fromJson(Map<String, dynamic> json) => _$LeaseModelFromJson(json);

@override final  String id;
@override final  String tenantId;
@override final  String unitId;
@override final  String propertyId;
@override final  String createdByAdminId;
// audit trail
@override final  RentPeriod rentPeriod;
@override final  LeaseStatus status;
@override final  double monthlyRent;
@override final  double securityDeposit;
@override final  double? agreementFee;
@override final  double? agencyFee;
@override final  double? serviceCharge;
@override final  int? paymentDueDay;
// 1-28 for recurring leases
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String? contractUrl;
// Firebase Storage PDF
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of LeaseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaseModelCopyWith<_LeaseModel> get copyWith => __$LeaseModelCopyWithImpl<_LeaseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.createdByAdminId, createdByAdminId) || other.createdByAdminId == createdByAdminId)&&(identical(other.rentPeriod, rentPeriod) || other.rentPeriod == rentPeriod)&&(identical(other.status, status) || other.status == status)&&(identical(other.monthlyRent, monthlyRent) || other.monthlyRent == monthlyRent)&&(identical(other.securityDeposit, securityDeposit) || other.securityDeposit == securityDeposit)&&(identical(other.agreementFee, agreementFee) || other.agreementFee == agreementFee)&&(identical(other.agencyFee, agencyFee) || other.agencyFee == agencyFee)&&(identical(other.serviceCharge, serviceCharge) || other.serviceCharge == serviceCharge)&&(identical(other.paymentDueDay, paymentDueDay) || other.paymentDueDay == paymentDueDay)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.contractUrl, contractUrl) || other.contractUrl == contractUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,unitId,propertyId,createdByAdminId,rentPeriod,status,monthlyRent,securityDeposit,agreementFee,agencyFee,serviceCharge,paymentDueDay,startDate,endDate,contractUrl,createdAt,updatedAt);

@override
String toString() {
  return 'LeaseModel(id: $id, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, createdByAdminId: $createdByAdminId, rentPeriod: $rentPeriod, status: $status, monthlyRent: $monthlyRent, securityDeposit: $securityDeposit, agreementFee: $agreementFee, agencyFee: $agencyFee, serviceCharge: $serviceCharge, paymentDueDay: $paymentDueDay, startDate: $startDate, endDate: $endDate, contractUrl: $contractUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LeaseModelCopyWith<$Res> implements $LeaseModelCopyWith<$Res> {
  factory _$LeaseModelCopyWith(_LeaseModel value, $Res Function(_LeaseModel) _then) = __$LeaseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tenantId, String unitId, String propertyId, String createdByAdminId, RentPeriod rentPeriod, LeaseStatus status, double monthlyRent, double securityDeposit, double? agreementFee, double? agencyFee, double? serviceCharge, int? paymentDueDay, DateTime startDate, DateTime endDate, String? contractUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$LeaseModelCopyWithImpl<$Res>
    implements _$LeaseModelCopyWith<$Res> {
  __$LeaseModelCopyWithImpl(this._self, this._then);

  final _LeaseModel _self;
  final $Res Function(_LeaseModel) _then;

/// Create a copy of LeaseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? unitId = null,Object? propertyId = null,Object? createdByAdminId = null,Object? rentPeriod = null,Object? status = null,Object? monthlyRent = null,Object? securityDeposit = null,Object? agreementFee = freezed,Object? agencyFee = freezed,Object? serviceCharge = freezed,Object? paymentDueDay = freezed,Object? startDate = null,Object? endDate = null,Object? contractUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_LeaseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,createdByAdminId: null == createdByAdminId ? _self.createdByAdminId : createdByAdminId // ignore: cast_nullable_to_non_nullable
as String,rentPeriod: null == rentPeriod ? _self.rentPeriod : rentPeriod // ignore: cast_nullable_to_non_nullable
as RentPeriod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LeaseStatus,monthlyRent: null == monthlyRent ? _self.monthlyRent : monthlyRent // ignore: cast_nullable_to_non_nullable
as double,securityDeposit: null == securityDeposit ? _self.securityDeposit : securityDeposit // ignore: cast_nullable_to_non_nullable
as double,agreementFee: freezed == agreementFee ? _self.agreementFee : agreementFee // ignore: cast_nullable_to_non_nullable
as double?,agencyFee: freezed == agencyFee ? _self.agencyFee : agencyFee // ignore: cast_nullable_to_non_nullable
as double?,serviceCharge: freezed == serviceCharge ? _self.serviceCharge : serviceCharge // ignore: cast_nullable_to_non_nullable
as double?,paymentDueDay: freezed == paymentDueDay ? _self.paymentDueDay : paymentDueDay // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,contractUrl: freezed == contractUrl ? _self.contractUrl : contractUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
