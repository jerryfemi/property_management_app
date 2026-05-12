import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/applications/providers/application_provider.dart';
import 'package:pro_app/core/features/applications/ui/identity_step.dart';
import 'package:pro_app/core/features/applications/ui/income_step.dart';
import 'package:pro_app/core/features/applications/ui/personal_step.dart';
import 'package:pro_app/core/features/applications/ui/step_progress_indicator.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/app_error_sheet.dart';
import 'package:pro_app/core/widgets/app_success_sheet.dart';
import 'package:pro_app/core/widgets/primary_button.dart';

/// Root screen for the multi-step rental application form.
///
/// Receives the selected [unit] from [UnitDetailScreen] via go_router `extra`.
/// Manages a [PageController] and collects data from each step before
/// submitting everything in one Firestore write on the final step.
class ApplicationFormScreen extends ConsumerStatefulWidget {
  const ApplicationFormScreen({super.key, required this.unit});

  /// The unit the guest is applying for. Passed via go_router extra.
  final UnitModel unit;

  @override
  ConsumerState<ApplicationFormScreen> createState() =>
      _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends ConsumerState<ApplicationFormScreen> {
  // ── Page controller & current page tracking ───────────────────────────────
  final _pageController = PageController();
  int _currentPage = 0;

  // ── One form key per step ─────────────────────────────────────────────────
  // We validate only the active step's form before advancing.
  final _personalKey = GlobalKey<FormState>();
  final _identityKey = GlobalKey<FormState>();
  final _incomeKey = GlobalKey<FormState>();

  // ── Accumulated form data ─────────────────────────────────────────────────
  // Each step calls onChanged() which merges its data into this map.
  // On submit, we read directly from this map.
  final Map<String, dynamic> _formData = {};

  static const _stepLabels = ['Personal', 'Identity', 'Income'];

  // ── Helpers ───────────────────────────────────────────────────────────────

  GlobalKey<FormState> get _currentFormKey =>
      [_personalKey, _identityKey, _incomeKey][_currentPage];

  bool get _isLastPage => _currentPage == _stepLabels.length - 1;

  // Called by each step widget whenever a field changes
  void _onStepDataChanged(Map<String, dynamic> stepData) {
    _formData.addAll(stepData);
  }

  // ── Navigation ────────────────────────────────────────────────────────────

  void _goNext() {
    final isValid = _currentFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_isLastPage) {
      _submitApplication();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    if (_currentPage == 0) {
      context.pop();
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // ── Submit ────────────────────────────────────────────────────────────────

  Future<void> _submitApplication() async {
    // Final validation
    final isValid = _currentFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Identity doc upload is required — guard here too
    if (_formData['idDocumentUrl'] == null) {
      AppErrorSheet.show(
        context,
        title: 'Document Required',
        message:
            'Please upload your ID document on the Identity step before submitting.',
      );
      return;
    }

    await ref
        .read(applicationFormProvider.notifier)
        .submit(
          unitId: widget.unit.id,
          propertyId: widget.unit.propertyId,
          fullName: _formData['full_name'] as String? ?? '',
          phone: _formData['phone'] as String? ?? '',
          currentAddress: _formData['current_address'] as String? ?? '',
          employmentStatus: _formData['employment_status'] as String? ?? '',
          monthlyIncome: (_formData['monthly_income'] as double?) ?? 0.0,
          occupants: (_formData['occupants'] as int?) ?? 1,
          hasPets: (_formData['has_pets'] as bool?) ?? false,
          idDocumentUrl: _formData['id_document_url'] as String?,
          incomeProofUrl: _formData['income_proof_url'] as String?,
        );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Get the uid for Storage uploads inside steps
    final uid = ref.watch(authStateProvider).value?.uid ?? '';

    // ── Listen for submit success / error ─────────────────────────────────
    ref.listen<AsyncValue<void>>(applicationFormProvider, (previous, next) {
      // Only show sheet if we were previously loading (i.e. a submission was in progress)
      if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
        AppSuccessSheet.show(
          context,
          title: 'Application Submitted!',
          message:
              'Your application for Unit ${widget.unit.unitNumber} has been received. '
              'We will review it and get back to you within 24–48 hours.',
          buttonText: 'Track Application',
          onConfirm: () {
            // Pop all the way back to the guest applications tab
            context.go('/guest/applications');
          },
        );
      }

      if (next is AsyncError) {
        AppErrorSheet.show(
          context,
          title: 'Submission Failed',
          message: next.error.toString(),
        );
      }
    });

    final submitState = ref.watch(applicationFormProvider);

    return Scaffold(
      // ── App Bar ─────────────────────────────────────────────────────────
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _goBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rental Application',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Unit ${widget.unit.unitNumber}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: appColors.muted,
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: StepProgressIndicator(
              steps: _stepLabels,
              currentStep: _currentPage,
            ),
          ),
        ),
      ),

      // ── Body: PageView ───────────────────────────────────────────────────
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              // Disable swipe — user must use Back/Next buttons
              // so validation always runs before advancing.
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                // Step 1 — Personal
                PersonalStep(
                  formKey: _personalKey,
                  initialData: _formData,
                  onChanged: _onStepDataChanged,
                ),

                // Step 2 — Identity
                IdentityStep(
                  formKey: _identityKey,
                  applicantId: uid,
                  initialData: _formData,
                  onChanged: _onStepDataChanged,
                ),

                // Step 3 — Income
                IncomeStep(
                  formKey: _incomeKey,
                  applicantId: uid,
                  initialData: _formData,
                  onChanged: _onStepDataChanged,
                ),
              ],
            ),
          ),

          // ── Bottom action bar ────────────────────────────────────────────
          _BottomBar(
            currentPage: _currentPage,
            isLastPage: _isLastPage,
            isLoading: submitState.isLoading,
            onBack: _goBack,
            onNext: _goNext,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom action bar — Back + Next/Submit
// ─────────────────────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.currentPage,
    required this.isLastPage,
    required this.isLoading,
    required this.onBack,
    required this.onNext,
  });

  final int currentPage;
  final bool isLastPage;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Row(
        children: [
          // Back button — shown on all pages
          SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: isLoading ? null : onBack,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: appColors.border),
              ),
              child: Text(
                'Back',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Next / Submit button
          Expanded(
            child: PrimaryButton(
              text: isLastPage ? 'Submit Application' : 'Continue',
              isLoading: isLoading,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
