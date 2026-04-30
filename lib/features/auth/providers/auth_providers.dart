import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_app/features/auth/data/auth_repository.dart';
import 'package:pro_app/features/auth/data/user_model.dart';
import 'package:pro_app/features/auth/data/user_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, GoogleSignIn());
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseFirestore.instance);
});

//  authStateProvider -- stream
final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// userRoleProvider -- role from token claims(go_router uses this to pick nav branch)
final userRoleProvider = FutureProvider.autoDispose<UserRole?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
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

final needsProfileCompletionProvider = Provider.autoDispose<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    loading: () => false,
    error: (_, _) => false,
    data: (user) {
      if (user == null) return false;
      return user.phone.trim().isEmpty;
    },
  );
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
      await _userRepo.updateProfile(uid, name: name, phone: phone);
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
      await _auth.signInWithEmail(email: email, password: password);
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
      final uid = credential.user!.uid;
      final displayName = credential.user!.displayName ?? '';
      if (displayName.isNotEmpty) {
        await _userRepo.updateProfile(uid, name: displayName);
      }
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.signInWithApple();
      final uid = credential.user!.uid;
      final displayName = credential.user!.displayName ?? '';
      if (displayName.isNotEmpty) {
        await _userRepo.updateProfile(uid, name: displayName);
      }
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

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
    state = const AsyncLoading();
    try {
      await _auth.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
