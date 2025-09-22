import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String message;
  final Widget icon;
  final TextStyle? textStyle;
  final Widget? action; // e.g. Retry button
  final EdgeInsetsGeometry padding;
  final double spacing;

  const StatusIndicator({
    super.key,
    required this.message,
    required this.icon,
    this.textStyle,
    this.action,
    this.padding = const EdgeInsets.all(24.0),
    this.spacing = 16.0,
  });

  /// Success factory
  factory StatusIndicator.success({
    Key? key,
    String message = "Success!",
    TextStyle? textStyle,
    Widget? action,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    double spacing = 16.0,
    Color? iconColor,
    double iconSize = 64,
  }) {
    return StatusIndicator(
      key: key,
      message: message,
      icon: Icon(Icons.check_circle, size: iconSize, color: iconColor),
      textStyle: textStyle,
      action: action,
      padding: padding,
      spacing: spacing,
    );
  }

  /// Error factory
  factory StatusIndicator.error({
    Key? key,
    String message = "Something went wrong.",
    TextStyle? textStyle,
    Widget? action,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    double spacing = 16.0,
    Color? iconColor,
    double iconSize = 64,
  }) {
    return StatusIndicator(
      key: key,
      message: message,
      icon: Icon(Icons.error_outline, size: iconSize, color: iconColor),
      textStyle: textStyle,
      action: action,
      padding: padding,
      spacing: spacing,
    );
  }

  /// Loading factory
  factory StatusIndicator.loading({
    Key? key,
    String message = "Loading...",
    TextStyle? textStyle,
    Widget? action,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    double spacing = 16.0,
    double size = 32,
    Color? color,
  }) {
    return StatusIndicator(
      key: key,
      message: message,
      icon: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3,
          valueColor:
              color != null ? AlwaysStoppedAnimation<Color>(color) : null,
        ),
      ),
      textStyle: textStyle,
      action: action,
      padding: padding,
      spacing: spacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: spacing),
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  textStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
            ),
            if (action != null) ...[SizedBox(height: spacing + 4), action!],
          ],
        ),
      ),
    );
  }
}
