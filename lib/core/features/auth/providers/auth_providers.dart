import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_app/core/features/auth/data/auth_repository.dart';
import 'package:pro_app/core/features/auth/data/user_model.dart';
import 'package:pro_app/core/features/auth/data/user_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, GoogleSignIn.instance);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance);
});

//  authStateProvider -- stream
final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// userRoleProvider — updated to fall back to Firestore role
// when Auth custom claim is null (workaround while functions are
// not deployed). Safe to revert once onUserCreate is live.
final userRoleProvider = FutureProvider.autoDispose<UserRole?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;

  // Try Auth custom claim first
  final token = await user.getIdTokenResult();
  final claimRole = token.claims?['role'] as String?;

  if (claimRole != null && claimRole.isNotEmpty) {
    return UserRole.fromString(claimRole);
  }

  // Fallback: read role from Firestore users doc
  final userDoc = ref.watch(currentUserProvider).value;
  if (userDoc != null) {
    return userDoc.role;
  }

  return UserRole.guest; // safe default
});

// current user provider -- stream
final currentUserProvider = StreamProvider.autoDispose<UserModel?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(null);
  return ref.watch(userRepositoryProvider).watchUser(user.uid);
});

// needsProfileCompletionProvider
// Returns true when the logged-in user's phone field is empty/null.
final needsProfileCompletionProvider = Provider.autoDispose<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  final user = userAsync.value;
  if (user == null) return false;
  return user.phone.trim().isEmpty;
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
      return AuthController(
        ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider),
      );
    });

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._auth, this._userRepo) : super(const AsyncData(null));

  final AuthRepository _auth;
  final UserRepository _userRepo;

  Future<void> signUpWithEmail({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.signUpWithEmail(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;
      // Client-side creation since functions aren't live
      await _userRepo.createUser(uid, name: name, email: email);
      await _userRepo.updateProfile(uid, phone: phone);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.signInWithEmail(email: email, password: password);
      // Ensure doc exists even for legacy users
      await _userRepo.createUser(credential.user!.uid, email: email);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.signInWithGoogle();
      if (credential == null) {
        state = const AsyncData(null);
        return;
      }
      final user = credential.user!;
      // Create/Update Firestore document
      await _userRepo.createUser(user.uid, name: user.displayName, email: user.email);
      state = const AsyncData(null);
    } catch (e, st) {
      debugPrint('=== GOOGLE SIGN-IN CONTROLLER ERROR ===');
      debugPrint('Error: $e');
      debugPrint('StackTrace: $st');
      state = AsyncError(e, st);
    }
  }

  // Future<void> signInWithApple() async {
  //   state = const AsyncLoading();
  //   try {
  //     final credential = await _auth.signInWithApple();
  //     if (credential == null) {
  //       state = const AsyncData(null);
  //       return;
  //     }
  //     final user = credential.user!;
  //     await _userRepo.createUser(user.uid, name: user.displayName, email: user.email);
  //     state = const AsyncData(null);
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }

  Future<void> sendPasswordReset(String email) async {
    state = const AsyncLoading();
    try {
      await _auth.sendPasswordReset(email);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> completeProfile({
    required String uid,
    required String name,
    required String phone,
  }) async {
    state = const AsyncLoading();
    try {
      await _userRepo.updateProfile(uid, name: name, phone: phone);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
