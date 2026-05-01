import 'package:flutter/cupertino.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: .bold,
        letterSpacing: 1.2,
        color: context.appColors.muted,
      ),
    );
  }
}
