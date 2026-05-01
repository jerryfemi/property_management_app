import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/primary_button.dart';

class AppErrorSheet extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onTryAgain;

  const AppErrorSheet({
    super.key,
    required this.title,
    required this.message,
    this.onTryAgain,
  });

  static void show(
    BuildContext context, {
    String title = 'Something went wrong',
    required String message,
    VoidCallback? onTryAgain,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AppErrorSheet(title: title, message: message, onTryAgain: onTryAgain),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: context.appColors.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 32),
            // Custom Shield Alert Image
            Image.asset(
              'assets/images/alert.png',
              height: 100,
              width: 100,
              errorBuilder: (context, error, stackTrace) => CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Message
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: context.appColors.muted,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Dismiss Button
            PrimaryButton(text: 'Dismiss', onPressed: () => context.pop()),
            // Optional Try Again Button
            if (onTryAgain != null) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.pop(); // Close sheet first
                  onTryAgain!();
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Try again',
                  style: TextStyle(
                    color: context.appColors.muted,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
