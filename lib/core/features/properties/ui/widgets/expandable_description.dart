import 'package:flutter/material.dart';

class ExpandableDescription extends StatelessWidget {
  final String text;
  final bool isExpanded;
  final VoidCallback onToggle;
  final ThemeData theme;
  final dynamic appColors;

  const ExpandableDescription({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.onToggle,
    required this.theme,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.muted,
              height: 1.6,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.muted,
              height: 1.6,
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
        if (text.length > 150) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              isExpanded ? 'Show less' : 'Read more',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
