import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/primary_button.dart';

class AppSuccessSheet extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onConfirm;

  const AppSuccessSheet({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'Got it',
    this.onConfirm,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'Got it',
    VoidCallback? onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppSuccessSheet(
        title: title,
        message: message,
        buttonText: buttonText,
        onConfirm: onConfirm,
      ),
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
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: context.appColors.muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 32),
            // Success Icon (Green)
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 50,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
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
            PrimaryButton(
              text: buttonText,
              onPressed: () {
                context.pop();
                if (onConfirm != null) onConfirm!();
              },
            ),
          ],
        ),
      ),
    );
  }
}
