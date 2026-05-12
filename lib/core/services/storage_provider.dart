import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Upload State
// Represents every possible state an upload can be in.
// ─────────────────────────────────────────────────────────────────────────────

sealed class UploadState {
  const UploadState();
}

/// No file selected yet / reset
class UploadIdle extends UploadState {
  const UploadIdle();
}

/// Currently uploading — progress is 0.0 to 1.0
class UploadInProgress extends UploadState {
  const UploadInProgress(this.progress);
  final double progress; // 0.0 – 1.0
}

/// Upload finished — holds the Firebase Storage download URL
class UploadSuccess extends UploadState {
  const UploadSuccess({required this.downloadUrl, required this.localFile});
  final String downloadUrl;
  final File localFile; // kept for thumbnail display
}

/// Upload failed — holds a human-readable message
class UploadFailure extends UploadState {
  const UploadFailure(this.message);
  final String message;
}

// ─────────────────────────────────────────────────────────────────────────────
// Storage Service
// Pure Dart class — no Flutter, no Riverpod.
// Owns the Firebase Storage interaction.
// ─────────────────────────────────────────────────────────────────────────────

class StorageService {
  StorageService(this._storage);
  final FirebaseStorage _storage;

  /// Uploads [file] to [storagePath] and streams progress via [onProgress].
  /// Returns the public download URL on success.
  /// Throws a [StorageException] on failure.
  Future<String> upload({
    required File file,
    required String storagePath,
    void Function(double progress)? onProgress,
  }) async {
    final ref = _storage.ref(storagePath);
    final task = ref.putFile(file);

    // Listen to upload progress
    task.snapshotEvents.listen((snapshot) {
      if (snapshot.totalBytes == 0) return;
      final progress = snapshot.bytesTransferred / snapshot.totalBytes;
      onProgress?.call(progress);
    });

    final snapshot = await task;
    return await snapshot.ref.getDownloadURL();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// StorageService Provider — DI only, lives forever
// ─────────────────────────────────────────────────────────────────────────────

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(FirebaseStorage.instance);
});

// ─────────────────────────────────────────────────────────────────────────────
// Upload Notifier
// One instance per upload slot (id_document, income_proof, etc.).
// Use .family so each slot is independent.
//
// Usage:
//   ref.watch(uploadNotifierProvider('id_document'))
//   ref.read(uploadNotifierProvider('id_document').notifier).upload(file, uid)
// ─────────────────────────────────────────────────────────────────────────────

final uploadNotifierProvider = StateNotifierProvider.autoDispose
    .family<UploadNotifier, UploadState, String>(
  (ref, slot) => UploadNotifier(ref.read(storageServiceProvider), slot),
);

class UploadNotifier extends StateNotifier<UploadState> {
  UploadNotifier(this._service, this._slot) : super(const UploadIdle());

  final StorageService _service;

  /// The slot name, e.g. 'id_document' or 'income_proof'.
  /// Combined with [applicantId] to form the Storage path.
  final String _slot;

  /// Start an upload for [applicantId].
  /// Storage path: applications/{applicantId}/{slot}
  ///
  /// Returns the download URL on success, null on failure.
  Future<String?> upload(File file, String applicantId) async {
    state = const UploadInProgress(0);

    try {
      final path = 'applications/$applicantId/$_slot';
      final url = await _service.upload(
        file: file,
        storagePath: path,
        onProgress: (p) {
          // Only update if we're still in progress (not cancelled)
          if (state is UploadInProgress) {
            state = UploadInProgress(p);
          }
        },
      );

      state = UploadSuccess(downloadUrl: url, localFile: file);
      return url;
    } on FirebaseException catch (e) {
      // Firebase gives us a code — translate to a readable message
      state = UploadFailure(_mapFirebaseError(e.code));
      return null;
    } catch (_) {
      state = const UploadFailure('Upload failed. Please try again.');
      return null;
    }
  }

  /// Reset back to idle (e.g. user wants to re-pick a file)
  void reset() => state = const UploadIdle();

  // ── Private helpers ────────────────────────────────────────────────────────

  String _mapFirebaseError(String code) {
    return switch (code) {
      'storage/unauthorized' =>
        'You do not have permission to upload. Please log in again.',
      'storage/canceled' => 'Upload was cancelled.',
      'storage/object-not-found' => 'File not found on device.',
      'storage/quota-exceeded' =>
        'Storage limit reached. Please contact support.',
      _ => 'Upload failed. Please check your connection and try again.',
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Slot name constants — import these instead of typing raw strings
// ─────────────────────────────────────────────────────────────────────────────

abstract final class UploadSlot {
  static const idDocument = 'id_document';
  static const incomeProof = 'income_proof';
  static const profilePicture = 'profile_picture';
  static const maintenanceImage = 'maintenance_image';
}