import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sendspace/core/data/models/dto/tables/users.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/theme/spacing.dart';

class MeAppBar extends StatelessWidget {
  final UsersRow user;

  const MeAppBar({super.key, required this.user});

  static const double _maxSliverHeight = 200;
  static const double _minSliverHeight = 88;

  static const double _baseImageSize = 96;
  static const double _minImageSize = 64;
  static const double _maxImageSize = 208;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: _maxSliverHeight,
      surfaceTintColor: Colors.transparent,
      backgroundColor: context.colorTheme.surface,
      collapsedHeight: _minSliverHeight,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = _maxSliverHeight;
          double percentage = constraints.maxHeight / maxHeight;
          percentage = pow(percentage, 3).toDouble();
          percentage = percentage.clamp(0.0, 1.0);

          return Stack(
            children: [
              Container(),
              _header(context, percentage),

              // Bottom-aligned data points (visible when expanded)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Opacity(
                  opacity: pow(percentage, 4).toDouble(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDataPoint("Climbs", 1722),
                      _buildDataPoint("Followers", 50),
                      _buildDataPoint("Following", 16),
                      _buildDataPoint("Projects", 3),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, double percentage) {
    final imageSize =
        (_baseImageSize * percentage)
            .clamp(_minImageSize, _maxImageSize)
            .toDouble();

    final isExpanded = percentage > 0.3;

    final baseNameStyle = Theme.of(context).textTheme.headlineLarge!;
    final gradeStyle = Theme.of(context).textTheme.headlineLarge!;

    final baseNameSize = baseNameStyle.fontSize ?? 24.0;
    final scaledNameStyle = baseNameStyle.copyWith(
      fontSize: lerpDouble(20, baseNameSize, percentage),
    );

    final scaledGradeVStyle = gradeStyle.copyWith(
      fontSize: lerpDouble(18, baseNameSize, percentage),
      fontWeight: FontWeight.bold,
      color: context.colorTheme.primary,
      shadows: [const Shadow(blurRadius: 4, color: Colors.black45)],
    );

    final scaledGradeNumberStyle = gradeStyle.copyWith(
      fontSize: lerpDouble(14, baseNameSize * 0.8, percentage),
      fontWeight: FontWeight.w500,
      color: context.colorTheme.primary,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Gap(Spacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              "https://image-cdn.essentiallysports.com/wp-content/uploads/explore-through-the-lens-alex-honnold_4x3.jpg?width=600",
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),
          Gap(Spacing.lg),
          Flex(
            direction: isExpanded ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment:
                isExpanded
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.displayName, style: scaledNameStyle),
              if (!isExpanded) Gap(Spacing.sm),
              RichText(
                text: TextSpan(
                  text: 'V',
                  style: scaledGradeVStyle,
                  children: [
                    TextSpan(text: '3', style: scaledGradeNumberStyle),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget for the data points
  Widget _buildDataPoint(String label, int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
