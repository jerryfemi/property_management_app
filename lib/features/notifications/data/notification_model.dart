import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required String type,
    required String title,
    required String message,
    required bool isRead,
    String? relatedId,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return NotificationModel(
      id: doc.id,
      userId: data['user_id'] as String,
      type: data['type'] as String,
      title: data['title'] as String,
      message: data['message'] as String,
      isRead: data['is_read'] as bool,
      relatedId: data['related_id'] as String?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
