import 'package:flutter/material.dart';
import 'package:pro_app/core/theme/app_theme.dart';

/// Step 1 — Personal Information
///
/// Collects: fullName, phone, currentAddress, occupants, hasPets.
/// The parent [ApplicationFormScreen] passes a [GlobalKey<FormState>] so it
/// can validate this page before allowing the user to advance.
class PersonalStep extends StatefulWidget {
  const PersonalStep({
    super.key,
    required this.formKey,
    required this.initialData,
    required this.onChanged,
  });

  /// Shared form key so the parent can call formKey.currentState!.validate()
  final GlobalKey<FormState> formKey;

  /// Pre-filled values (empty map on first visit)
  final Map<String, dynamic> initialData;

  /// Called whenever any field changes so the parent can store the latest data
  final void Function(Map<String, dynamic> data) onChanged;

  @override
  State<PersonalStep> createState() => _PersonalStepState();
}

class _PersonalStepState extends State<PersonalStep> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _occupantsCtrl;
  bool _hasPets = false;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _nameCtrl = TextEditingController(text: d['full_name'] as String? ?? '');
    _phoneCtrl = TextEditingController(text: d['phone'] as String? ?? '');
    _addressCtrl =
        TextEditingController(text: d['current_address'] as String? ?? '');
    _occupantsCtrl = TextEditingController(
      text: d['occupants'] != null ? '${d['occupants']}' : '',
    );
    _hasPets = d['has_pets'] as bool? ?? false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _occupantsCtrl.dispose();
    super.dispose();
  }

  void _notify() {
    widget.onChanged({
      'full_name': _nameCtrl.text.trim(),
      'phone': _phoneCtrl.text.trim(),
      'current_address': _addressCtrl.text.trim(),
      'occupants': int.tryParse(_occupantsCtrl.text.trim()) ?? 1,
      'has_pets': _hasPets,
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

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
              'Personal Information',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tell us a bit about yourself.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.muted,
              ),
            ),
            const SizedBox(height: 28),

            // ── Full Name ──────────────────────────────────────────────────
            _FormLabel(label: 'Full Name'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => _notify(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Full name is required' : null,
              decoration: const InputDecoration(hintText: 'e.g. Kemi Olayinka'),
            ),
            const SizedBox(height: 20),

            // ── Phone ──────────────────────────────────────────────────────
            _FormLabel(label: 'Phone Number'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              onChanged: (_) => _notify(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Phone number is required' : null,
              decoration:
                  const InputDecoration(hintText: '+234 800 000 0000'),
            ),
            const SizedBox(height: 20),

            // ── Current Address ────────────────────────────────────────────
            _FormLabel(label: 'Current Address'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressCtrl,
              maxLines: 3,
              onChanged: (_) => _notify(),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Current address is required'
                  : null,
              decoration: const InputDecoration(
                hintText: '12 Bode Thomas Street, Surulere, Lagos',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),

            // ── Number of Occupants ────────────────────────────────────────
            _FormLabel(label: 'Number of Occupants'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _occupantsCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => _notify(),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = int.tryParse(v.trim());
                if (n == null || n < 1) return 'Enter a valid number';
                return null;
              },
              decoration:
                  const InputDecoration(hintText: 'Including yourself'),
            ),
            const SizedBox(height: 28),

            // ── Pets toggle ────────────────────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: appColors.border),
              ),
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Do you have pets?',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Cats, dogs, or other animals',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.muted,
                  ),
                ),
                value: _hasPets,
                activeColor: theme.colorScheme.primary,
                onChanged: (val) {
                  setState(() => _hasPets = val);
                  _notify();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small reusable label widget
// ─────────────────────────────────────────────────────────────────────────────
class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}