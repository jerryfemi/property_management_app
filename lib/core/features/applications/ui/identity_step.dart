import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_app/core/services/storage_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';

/// Step 2 — Identity Verification
///
/// Watches [uploadNotifierProvider] with slot [UploadSlot.idDocument].
/// Upload progress and errors come from the notifier — no local upload state.
class IdentityStep extends ConsumerStatefulWidget {
  const IdentityStep({
    super.key,
    required this.formKey,
    required this.applicantId,
    required this.initialData,
    required this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final String applicantId;
  final Map<String, dynamic> initialData;
  final void Function(Map<String, dynamic> data) onChanged;

  @override
  ConsumerState<IdentityStep> createState() => _IdentityStepState();
}

class _IdentityStepState extends ConsumerState<IdentityStep> {
  String _selectedIdType = 'National ID (NIN)';
  late final TextEditingController _idNumberCtrl;

  static const _idTypes = [
    'National ID (NIN)',
    'International Passport',
    "Driver's License",
    "Voter's Card",
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _selectedIdType = d['idType'] as String? ?? _idTypes.first;
    _idNumberCtrl = TextEditingController(text: d['id_number'] as String? ?? '');
  }

  @override
  void dispose() {
    _idNumberCtrl.dispose();
    super.dispose();
  }

  void _notify(String? downloadUrl) {
    widget.onChanged({
      'id_type': _selectedIdType,
      'id_number': _idNumberCtrl.text.trim(),
      'id_document_url': downloadUrl,
    });
  }

  Future<void> _pickAndUpload() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    // Kick off upload — notifier handles progress + error state
    final url = await ref
        .read(uploadNotifierProvider(UploadSlot.idDocument).notifier)
        .upload(File(picked.path), widget.applicantId);

    // url is null if upload failed — parent is told either way
    _notify(url);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Watch upload state — widget rebuilds automatically on every change
    final uploadState = ref.watch(
      uploadNotifierProvider(UploadSlot.idDocument),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──────────────────────────────────────────────────────
            Text(
              'Identity Verification',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Please upload a clear picture of your valid government-issued ID card.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.muted,
              ),
            ),
            const SizedBox(height: 28),

            // ── ID Type ────────────────────────────────────────────────────
            _FormLabel(label: 'ID Type'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedIdType,
              decoration: const InputDecoration(),
              items: _idTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) {
                if (val == null) return;
                setState(() => _selectedIdType = val);
                final url = uploadState is UploadSuccess
                    ? uploadState.downloadUrl
                    : null;
                _notify(url);
              },
            ),
            const SizedBox(height: 20),

            // ── Upload box ─────────────────────────────────────────────────
            _FormLabel(label: 'Upload Document'),
            const SizedBox(height: 8),
            _IdUploadBox(uploadState: uploadState, onTap: _pickAndUpload),

            // Hidden FormField — blocks Next if no successful upload yet
            FormField<void>(
              validator: (_) {
                if (uploadState is UploadSuccess) return null;
                if (uploadState is UploadInProgress) {
                  return 'Please wait for the upload to complete';
                }
                return 'Please upload your ID document to continue';
              },
              builder: (state) {
                if (!state.hasError) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ── ID Number ──────────────────────────────────────────────────
            _FormLabel(label: 'ID Number'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _idNumberCtrl,
              textCapitalization: TextCapitalization.characters,
              onChanged: (_) {
                final url = uploadState is UploadSuccess
                    ? uploadState.downloadUrl
                    : null;
                _notify(url);
              },
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'ID number is required'
                  : null,
              decoration: const InputDecoration(
                hintText: 'Enter your ID number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Upload box — switches on UploadState sealed class
// ─────────────────────────────────────────────────────────────────────────────

class _IdUploadBox extends StatelessWidget {
  const _IdUploadBox({required this.uploadState, required this.onTap});

  final UploadState uploadState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final appColors = context.appColors;

    return switch (uploadState) {
      // ── Success ───────────────────────────────────────────────────────────
      UploadSuccess(:final localFile) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green, width: 2),
            image: DecorationImage(
              image: FileImage(localFile),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.green,
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
            ),
          ),
        ),
      ),

      // ── In progress ───────────────────────────────────────────────────────
      UploadInProgress(:final progress) => Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primary.withValues(alpha: 0.4)),
          color: primary.withValues(alpha: 0.04),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: primary.withValues(alpha: 0.15),
                color: primary,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 12),
              Text(
                'Uploading… ${(progress * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Failure ───────────────────────────────────────────────────────────
      UploadFailure(:final message) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.error.withValues(alpha: 0.6),
              width: 1.5,
            ),
            color: theme.colorScheme.error.withValues(alpha: 0.04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: theme.colorScheme.error,
                size: 28,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to try again',
                textAlign: TextAlign.center,
                style: TextStyle(color: appColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),

      // ── Idle ──────────────────────────────────────────────────────────────
      UploadIdle() => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: primary.withValues(alpha: 0.4),
              width: 1.5,
            ),
            color: primary.withValues(alpha: 0.04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.upload_rounded, color: primary, size: 26),
              ),
              const SizedBox(height: 10),
              Text(
                'Tap to upload file',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'JPEG, PNG or PDF (Max 5MB)',
                textAlign: TextAlign.center,
                style: TextStyle(color: appColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Label widget
// ─────────────────────────────────────────────────────────────────────────────

class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
