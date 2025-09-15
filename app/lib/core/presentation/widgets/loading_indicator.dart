import 'dart:async';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final String loadingText;
  final String timeoutText;
  final Duration timeoutDuration;
  final double spacing;
  final Widget? indicator;
  final TextStyle? textStyle;

  const LoadingIndicator({
    super.key,
    this.loadingText = "Loading...",
    this.timeoutText = "This is taking longer than expected",
    this.timeoutDuration = const Duration(seconds: 3),
    this.spacing = 16.0,
    this.indicator,
    this.textStyle,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  bool _timedOut = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.timeoutDuration, () {
      if (mounted) {
        setState(() => _timedOut = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _timedOut ? widget.timeoutText : widget.loadingText,
            style:
                widget.textStyle ??
                theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          if (!_timedOut) ...[
            SizedBox(height: widget.spacing),
            widget.indicator ?? const CircularProgressIndicator.adaptive(),
          ],
        ],
      ),
    );
  }
}
