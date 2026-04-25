// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationModel {

 String get id; String get applicantId; String get unitId; String get propertyId; ApplicationStatus get applicationStatus; String get fullName; String get phone; String get currentAddress; String? get idDocumentUrl; String? get incomeProofUrl; String get employmentStatus; double get monthlyIncome; int get occupants; bool get hasPets; String? get landlordNote; String? get rejectionReason; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationModelCopyWith<ApplicationModel> get copyWith => _$ApplicationModelCopyWithImpl<ApplicationModel>(this as ApplicationModel, _$identity);

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.currentAddress, currentAddress) || other.currentAddress == currentAddress)&&(identical(other.idDocumentUrl, idDocumentUrl) || other.idDocumentUrl == idDocumentUrl)&&(identical(other.incomeProofUrl, incomeProofUrl) || other.incomeProofUrl == incomeProofUrl)&&(identical(other.employmentStatus, employmentStatus) || other.employmentStatus == employmentStatus)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.occupants, occupants) || other.occupants == occupants)&&(identical(other.hasPets, hasPets) || other.hasPets == hasPets)&&(identical(other.landlordNote, landlordNote) || other.landlordNote == landlordNote)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,applicantId,unitId,propertyId,applicationStatus,fullName,phone,currentAddress,idDocumentUrl,incomeProofUrl,employmentStatus,monthlyIncome,occupants,hasPets,landlordNote,rejectionReason,createdAt,updatedAt);

@override
String toString() {
  return 'ApplicationModel(id: $id, applicantId: $applicantId, unitId: $unitId, propertyId: $propertyId, applicationStatus: $applicationStatus, fullName: $fullName, phone: $phone, currentAddress: $currentAddress, idDocumentUrl: $idDocumentUrl, incomeProofUrl: $incomeProofUrl, employmentStatus: $employmentStatus, monthlyIncome: $monthlyIncome, occupants: $occupants, hasPets: $hasPets, landlordNote: $landlordNote, rejectionReason: $rejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ApplicationModelCopyWith<$Res>  {
  factory $ApplicationModelCopyWith(ApplicationModel value, $Res Function(ApplicationModel) _then) = _$ApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id, String applicantId, String unitId, String propertyId, ApplicationStatus applicationStatus, String fullName, String phone, String currentAddress, String? idDocumentUrl, String? incomeProofUrl, String employmentStatus, double monthlyIncome, int occupants, bool hasPets, String? landlordNote, String? rejectionReason, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._self, this._then);

  final ApplicationModel _self;
  final $Res Function(ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicantId = null,Object? unitId = null,Object? propertyId = null,Object? applicationStatus = null,Object? fullName = null,Object? phone = null,Object? currentAddress = null,Object? idDocumentUrl = freezed,Object? incomeProofUrl = freezed,Object? employmentStatus = null,Object? monthlyIncome = null,Object? occupants = null,Object? hasPets = null,Object? landlordNote = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,currentAddress: null == currentAddress ? _self.currentAddress : currentAddress // ignore: cast_nullable_to_non_nullable
as String,idDocumentUrl: freezed == idDocumentUrl ? _self.idDocumentUrl : idDocumentUrl // ignore: cast_nullable_to_non_nullable
as String?,incomeProofUrl: freezed == incomeProofUrl ? _self.incomeProofUrl : incomeProofUrl // ignore: cast_nullable_to_non_nullable
as String?,employmentStatus: null == employmentStatus ? _self.employmentStatus : employmentStatus // ignore: cast_nullable_to_non_nullable
as String,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,occupants: null == occupants ? _self.occupants : occupants // ignore: cast_nullable_to_non_nullable
as int,hasPets: null == hasPets ? _self.hasPets : hasPets // ignore: cast_nullable_to_non_nullable
as bool,landlordNote: freezed == landlordNote ? _self.landlordNote : landlordNote // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationModel].
extension ApplicationModelPatterns on ApplicationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationModel value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String applicantId,  String unitId,  String propertyId,  ApplicationStatus applicationStatus,  String fullName,  String phone,  String currentAddress,  String? idDocumentUrl,  String? incomeProofUrl,  String employmentStatus,  double monthlyIncome,  int occupants,  bool hasPets,  String? landlordNote,  String? rejectionReason,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.applicantId,_that.unitId,_that.propertyId,_that.applicationStatus,_that.fullName,_that.phone,_that.currentAddress,_that.idDocumentUrl,_that.incomeProofUrl,_that.employmentStatus,_that.monthlyIncome,_that.occupants,_that.hasPets,_that.landlordNote,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String applicantId,  String unitId,  String propertyId,  ApplicationStatus applicationStatus,  String fullName,  String phone,  String currentAddress,  String? idDocumentUrl,  String? incomeProofUrl,  String employmentStatus,  double monthlyIncome,  int occupants,  bool hasPets,  String? landlordNote,  String? rejectionReason,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel():
return $default(_that.id,_that.applicantId,_that.unitId,_that.propertyId,_that.applicationStatus,_that.fullName,_that.phone,_that.currentAddress,_that.idDocumentUrl,_that.incomeProofUrl,_that.employmentStatus,_that.monthlyIncome,_that.occupants,_that.hasPets,_that.landlordNote,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String applicantId,  String unitId,  String propertyId,  ApplicationStatus applicationStatus,  String fullName,  String phone,  String currentAddress,  String? idDocumentUrl,  String? incomeProofUrl,  String employmentStatus,  double monthlyIncome,  int occupants,  bool hasPets,  String? landlordNote,  String? rejectionReason,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.applicantId,_that.unitId,_that.propertyId,_that.applicationStatus,_that.fullName,_that.phone,_that.currentAddress,_that.idDocumentUrl,_that.incomeProofUrl,_that.employmentStatus,_that.monthlyIncome,_that.occupants,_that.hasPets,_that.landlordNote,_that.rejectionReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationModel implements ApplicationModel {
   _ApplicationModel({required this.id, required this.applicantId, required this.unitId, required this.propertyId, required this.applicationStatus, required this.fullName, required this.phone, required this.currentAddress, this.idDocumentUrl, this.incomeProofUrl, required this.employmentStatus, required this.monthlyIncome, required this.occupants, required this.hasPets, this.landlordNote, this.rejectionReason, required this.createdAt, required this.updatedAt});
  factory _ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

@override final  String id;
@override final  String applicantId;
@override final  String unitId;
@override final  String propertyId;
@override final  ApplicationStatus applicationStatus;
@override final  String fullName;
@override final  String phone;
@override final  String currentAddress;
@override final  String? idDocumentUrl;
@override final  String? incomeProofUrl;
@override final  String employmentStatus;
@override final  double monthlyIncome;
@override final  int occupants;
@override final  bool hasPets;
@override final  String? landlordNote;
@override final  String? rejectionReason;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationModelCopyWith<_ApplicationModel> get copyWith => __$ApplicationModelCopyWithImpl<_ApplicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.currentAddress, currentAddress) || other.currentAddress == currentAddress)&&(identical(other.idDocumentUrl, idDocumentUrl) || other.idDocumentUrl == idDocumentUrl)&&(identical(other.incomeProofUrl, incomeProofUrl) || other.incomeProofUrl == incomeProofUrl)&&(identical(other.employmentStatus, employmentStatus) || other.employmentStatus == employmentStatus)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.occupants, occupants) || other.occupants == occupants)&&(identical(other.hasPets, hasPets) || other.hasPets == hasPets)&&(identical(other.landlordNote, landlordNote) || other.landlordNote == landlordNote)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,applicantId,unitId,propertyId,applicationStatus,fullName,phone,currentAddress,idDocumentUrl,incomeProofUrl,employmentStatus,monthlyIncome,occupants,hasPets,landlordNote,rejectionReason,createdAt,updatedAt);

@override
String toString() {
  return 'ApplicationModel(id: $id, applicantId: $applicantId, unitId: $unitId, propertyId: $propertyId, applicationStatus: $applicationStatus, fullName: $fullName, phone: $phone, currentAddress: $currentAddress, idDocumentUrl: $idDocumentUrl, incomeProofUrl: $incomeProofUrl, employmentStatus: $employmentStatus, monthlyIncome: $monthlyIncome, occupants: $occupants, hasPets: $hasPets, landlordNote: $landlordNote, rejectionReason: $rejectionReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ApplicationModelCopyWith<$Res> implements $ApplicationModelCopyWith<$Res> {
  factory _$ApplicationModelCopyWith(_ApplicationModel value, $Res Function(_ApplicationModel) _then) = __$ApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String applicantId, String unitId, String propertyId, ApplicationStatus applicationStatus, String fullName, String phone, String currentAddress, String? idDocumentUrl, String? incomeProofUrl, String employmentStatus, double monthlyIncome, int occupants, bool hasPets, String? landlordNote, String? rejectionReason, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ApplicationModelCopyWithImpl<$Res>
    implements _$ApplicationModelCopyWith<$Res> {
  __$ApplicationModelCopyWithImpl(this._self, this._then);

  final _ApplicationModel _self;
  final $Res Function(_ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicantId = null,Object? unitId = null,Object? propertyId = null,Object? applicationStatus = null,Object? fullName = null,Object? phone = null,Object? currentAddress = null,Object? idDocumentUrl = freezed,Object? incomeProofUrl = freezed,Object? employmentStatus = null,Object? monthlyIncome = null,Object? occupants = null,Object? hasPets = null,Object? landlordNote = freezed,Object? rejectionReason = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,currentAddress: null == currentAddress ? _self.currentAddress : currentAddress // ignore: cast_nullable_to_non_nullable
as String,idDocumentUrl: freezed == idDocumentUrl ? _self.idDocumentUrl : idDocumentUrl // ignore: cast_nullable_to_non_nullable
as String?,incomeProofUrl: freezed == incomeProofUrl ? _self.incomeProofUrl : incomeProofUrl // ignore: cast_nullable_to_non_nullable
as String?,employmentStatus: null == employmentStatus ? _self.employmentStatus : employmentStatus // ignore: cast_nullable_to_non_nullable
as String,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,occupants: null == occupants ? _self.occupants : occupants // ignore: cast_nullable_to_non_nullable
as int,hasPets: null == hasPets ? _self.hasPets : hasPets // ignore: cast_nullable_to_non_nullable
as bool,landlordNote: freezed == landlordNote ? _self.landlordNote : landlordNote // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
