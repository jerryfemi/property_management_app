import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/notifications/data/notification_model.dart';

class NotificationRepository {
  NotificationRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('notifications');

  // all notifications for user
  Stream<List<NotificationModel>> watchForUser(String userId) => _collection
      .where('user_id', isEqualTo: userId)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map(
        (snapshots) =>
            snapshots.docs.map(NotificationModel.fromFirestore).toList(),
      );

  // mark  a notification as read
  Future<void> markAsRead(String notificationId) =>
      _collection.doc(notificationId).update({'is_read': true});

  // mark all unread notification for user
  Future<void> markAllRead(String userId) async {
    // get all unread notifications
    final unread = await _collection
        .where('user_id', isEqualTo: userId)
        .where('is_read', isEqualTo: false)
        .get();

    final batch = _db.batch();
    for (final doc in unread.docs) {
      batch.update(doc.reference, {'is_read': true});
    }
    await batch.commit();
  }

  // delete notification
  Future<void> delete(String notificationId) =>
      _collection.doc(notificationId).delete();
}
