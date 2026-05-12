import 'package:flutter/material.dart';
import 'package:pro_app/core/theme/app_theme.dart';

/// A horizontal step tracker widget showing Personal → Identity → Income.
///
/// Usage:
///   StepProgressIndicator(
///     steps: ['Personal', 'Identity', 'Income'],
///     currentStep: 1, // 0-indexed
///   )
class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  final List<String> steps;

  /// 0-indexed. 0 = first step active.
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final primary = theme.colorScheme.primary;

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        // Even indices are step circles; odd indices are connector lines
        if (index.isOdd) {
          // ── Connector line between two steps ──
          final leftStepIndex = index ~/ 2;
          final isDone = leftStepIndex < currentStep;

          return Expanded(
            child: Container(
              height: 2,
              color: isDone ? primary : appColors.border,
            ),
          );
        }

        // ── Step circle ──
        final stepIndex = index ~/ 2;
        final isDone = stepIndex < currentStep;
        final isActive = stepIndex == currentStep;
        final label = steps[stepIndex];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone || isActive ? primary : Colors.transparent,
                border: Border.all(
                  color: isDone || isActive ? primary : appColors.border,
                  width: 2,
                ),
              ),
              child: Center(
                child: isDone
                    // Completed: show checkmark
                    ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                    // Active or future: show step number
                    : Text(
                        '${stepIndex + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: isActive ? Colors.white : appColors.muted,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 5),

            // Label
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isDone || isActive ? primary : appColors.muted,
              ),
            ),
          ],
        );
      }),
    );
  }
}