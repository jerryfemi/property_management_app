import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserRole {
  guest,
  tenant,
  staff,
  admin;

  static UserRole fromString(String value) =>
      values.firstWhere((e) => e.name == value, orElse: () => UserRole.guest);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String phone,
    required UserRole role,
    String? profileImage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      id: doc.id,
      name: data['name'] as String,
      phone: data['phone'] as String,
      role: UserRole.fromString(data['role'] as String),
      profileImage: data['profile_image'] as String?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
