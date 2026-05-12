import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_app/core/services/storage_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';

/// Step 3 — Income & Employment
///
/// Watches [uploadNotifierProvider] with slot [UploadSlot.incomeProof].
/// Income proof upload is optional — user can submit without it.
class IncomeStep extends ConsumerStatefulWidget {
  const IncomeStep({
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
  ConsumerState<IncomeStep> createState() => _IncomeStepState();
}

class _IncomeStepState extends ConsumerState<IncomeStep> {
  String _selectedStatus = 'Employed';
  late final TextEditingController _incomeCtrl;

  static const _statuses = [
    'Employed',
    'Self-Employed',
    'Business Owner',
    'Student',
    'Unemployed',
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _selectedStatus = d['employment_status'] as String? ?? _statuses.first;
    _incomeCtrl = TextEditingController(
      text: d['monthly_income'] != null ? '${d['monthly_income']}' : '',
    );
  }

  @override
  void dispose() {
    _incomeCtrl.dispose();
    super.dispose();
  }

  void _notify(String? proofUrl) {
    widget.onChanged({
      'employment_status': _selectedStatus,
      'monthly_income': double.tryParse(
            _incomeCtrl.text.trim().replaceAll(',', ''),
          ) ??
          0.0,
      'income_proof_url': proofUrl, // nullable — proof is optional
    });
  }

  Future<void> _pickAndUpload() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    final url = await ref
        .read(uploadNotifierProvider(UploadSlot.incomeProof).notifier)
        .upload(File(picked.path), widget.applicantId);

    _notify(url);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Watch the income proof upload state
    final uploadState =
        ref.watch(uploadNotifierProvider(UploadSlot.incomeProof));

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
              'Income & Employment',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Help us understand your financial situation.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.muted,
              ),
            ),
            const SizedBox(height: 28),

            // ── Employment Status ──────────────────────────────────────────
            _FormLabel(label: 'Employment Status'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(),
              items: _statuses
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                if (val == null) return;
                setState(() => _selectedStatus = val);
                final url = uploadState is UploadSuccess
                    ? uploadState.downloadUrl
                    : null;
                _notify(url);
              },
            ),
            const SizedBox(height: 20),

            // ── Monthly Income ─────────────────────────────────────────────
            _FormLabel(label: 'Monthly Income (₦)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _incomeCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) {
                final url = uploadState is UploadSuccess
                    ? uploadState.downloadUrl
                    : null;
                _notify(url);
              },
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Monthly income is required';
                }
                final n = double.tryParse(v.trim().replaceAll(',', ''));
                if (n == null || n <= 0) return 'Enter a valid amount';
                return null;
              },
              decoration: const InputDecoration(
                hintText: '500,000',
                prefixText: '₦ ',
              ),
            ),
            const SizedBox(height: 28),

            // ── Income Proof Upload (optional) ─────────────────────────────
            Row(
              children: [
                _FormLabel(label: 'Proof of Income'),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: appColors.muted.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Optional',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: appColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Bank statement or payslip strengthens your application.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: appColors.muted,
              ),
            ),
            const SizedBox(height: 10),

            // Upload box — optional so no blocking FormField validator
            _IncomeUploadBox(
              uploadState: uploadState,
              onTap: _pickAndUpload,
            ),

            const SizedBox(height: 28),

            // ── Info banner ────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Your information is kept strictly confidential and is only shared with the property manager for this application.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Income upload box — optional, so no error state blocks progression
// ─────────────────────────────────────────────────────────────────────────────

class _IncomeUploadBox extends StatelessWidget {
  const _IncomeUploadBox({required this.uploadState, required this.onTap});

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
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    localFile,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.check, color: Colors.white, size: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Document uploaded',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Tap to change',
                      style: TextStyle(color: appColors.muted, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

      // ── In progress ───────────────────────────────────────────────────────
      UploadInProgress(:final progress) => Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: primary.withValues(alpha: 0.3)),
            color: primary.withValues(alpha: 0.04),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
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
                const SizedBox(height: 10),
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

      // ── Failure — shows error inline but still tappable to retry ──────────
      UploadFailure(:final message) => GestureDetector(
          onTap: onTap,
          child: Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.colorScheme.error.withValues(alpha: 0.5),
              ),
              color: theme.colorScheme.error.withValues(alpha: 0.04),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_outlined,
                    color: theme.colorScheme.error, size: 24),
                const SizedBox(height: 6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Tap to retry',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: appColors.muted, fontSize: 11),
                ),
              ],
            ),
          ),
        ),

      // ── Idle ──────────────────────────────────────────────────────────────
      UploadIdle() => GestureDetector(
          onTap: onTap,
          child: Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: primary.withValues(alpha: 0.35),
                width: 1.5,
              ),
              color: primary.withValues(alpha: 0.04),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.upload_file_rounded, color: primary, size: 28),
                const SizedBox(height: 8),
                Text(
                  'Upload bank statement or payslip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'JPEG, PNG or PDF',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: appColors.muted, fontSize: 11),
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
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}