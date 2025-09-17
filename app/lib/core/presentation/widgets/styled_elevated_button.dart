import 'package:flutter/material.dart';
import 'package:sendspace/core/extensions/build_context.dart';

/// The only reason this widget exists, is because
/// there's no easy way in flutter to simply say
/// ElevatedButton.primary .secondary, etc. This
/// is a useless wrapper, and I wish someone smarter
/// than I would show me a better way of doing it
/// that allows you to be able to change all instances
/// should a refactor be deemed necessary.
class StyledElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final ButtonStyle? style;

  const StyledElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.style,
  });

  // Primary factory
  factory StyledElevatedButton.primary({
    required BuildContext context,
    required VoidCallback? onPressed,
    required Widget child,
    Widget? icon,
  }) {
    return StyledElevatedButton(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: child,
    );
  }

  // Secondary factory
  factory StyledElevatedButton.secondary({
    required BuildContext context,
    required VoidCallback? onPressed,
    required Widget child,
    Widget? icon,
  }) {
    return StyledElevatedButton(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.secondary,
        foregroundColor: context.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: child,
    );
  }

  factory StyledElevatedButton.neutral({
    required BuildContext context,
    required VoidCallback? onPressed,
    required Widget child,
    Widget? icon,
  }) {
    return StyledElevatedButton(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.onSurface,
        foregroundColor: context.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: child,
        style: style,
      );
    }
    return ElevatedButton(onPressed: onPressed, style: style, child: child);
  }
}
