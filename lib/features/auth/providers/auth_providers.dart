import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/features/auth/data/user_model.dart';
import 'package:pro_app/features/auth/data/user_repository.dart';

// userRepoProvider --DI
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance);
});

//  authStateProvider -- stream
final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// userRoleProvider -- role from token claims(go_router uses this to pick nav branch)
final userRoleProvider = FutureProvider.autoDispose<UserRole>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return UserRole.guest;
  final token = await user.getIdTokenResult(true);

  final role = token.claims?['role'] as String? ?? 'guest';
  return UserRole.fromString(role);
});

// current user provider -- stream
final currentUserProvider = StreamProvider.autoDispose<UserModel?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref.watch(userRepositoryProvider).watchUser(user.uid);
});
