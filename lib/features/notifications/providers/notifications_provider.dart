import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/features/auth/providers/auth_providers.dart';
import 'package:pro_app/features/notifications/data/notification_model.dart';
import 'package:pro_app/features/notifications/data/notification_repository.dart';

// notification repo provider  - DI
final notificationsRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(FirebaseFirestore.instance);
});

// current users notifications
final notificationsProvider =
    StreamProvider.autoDispose<List<NotificationModel>>((ref) {
      final userId = ref.watch(authStateProvider).value?.uid;
      if (userId == null) return Stream.value([]);

      return ref.watch(notificationsRepositoryProvider).watchForUser(userId);
    });

// unread count for the homescreen icon
final unreadCountProvider = Provider.autoDispose((ref) {
  // get notifications
  final notifications = ref.watch(notificationsProvider).value ?? [];

  // get the lenght
  return notifications.where((notification) => !notification.isRead).length;
});

// unread otifications only
final unreadNotificationsProvider = Provider.autoDispose((ref) {
  return ref
      .watch(notificationsProvider)
      .whenData(
        (notifications) =>
            notifications.where((notification) => notification.isRead).toList(),
      );
});

// notifier provider
final notificationactionsProvider =
    StateNotifierProvider.autoDispose<
      NotificationsActionNotifier,
      AsyncValue<void>
    >((ref) {
      final repo = ref.watch(notificationsRepositoryProvider);
      final uid = ref.watch(authStateProvider).value?.uid;
      return NotificationsActionNotifier(repo, uid);
    });

//  notifier class
class NotificationsActionNotifier extends StateNotifier<AsyncValue<void>> {
  NotificationsActionNotifier(this._repo, this._uid)
    : super(const AsyncData(null));
  final NotificationRepository _repo;
 final String? _uid;

  Future<void> markRead(String notificationId) async {
    state = const AsyncLoading();

    try {
      await _repo.markAsRead(notificationId);
      state = const AsyncData(null);
    } catch (e, st) {
      AsyncError(e, st);
    }
  }

  // mark all as read
  Future<void> markAllRead() async {
    if (_uid == null) return;
    state = const AsyncLoading();
    try {
      await _repo.markAllRead(_uid);
      state = const AsyncData(null);
    } catch (e, st) {
      AsyncError(e, st);
    }
  }

  // delete notification
  Future<void> delete(String notificationId) async {
    state = const AsyncLoading();
    try {
      await _repo.delete(notificationId);
      state = const AsyncData(null);
    } catch (e, st) {
      AsyncError(e, st);
    }
  }
}
