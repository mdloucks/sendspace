import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/features/me/presentation/widgets/profile_avatar.dart';
import 'package:sendspace/theme/spacing.dart';

class MeProfileHeader extends StatelessWidget {
  /// Profile header that dynamically resizes depending on how
  /// large the container is. For a static header, use one of
  /// the factory constructors.
  const MeProfileHeader({
    super.key,
    required this.minImageSize,
    required this.maxImageSize,
    required this.minTextSize,
    required this.maxTextSize,
    required this.profile,
    required this.percentage,
    this.localAssetPath,
    this.trailing,
  });

  /// Full profile header, no wrapping.
  factory MeProfileHeader.large({
    Key? key,
    required ProfilesRow profile,
    Widget? trailing,
    String? localAssetPath,
  }) {
    return MeProfileHeader(
      key: key,
      minImageSize: 64.0,
      maxImageSize: 86.0,
      minTextSize: 18.0,
      maxTextSize: 28.0,
      profile: profile,
      percentage: 1,
      trailing: trailing,
      localAssetPath: localAssetPath,
    );
  }

  /// Condensed profile header, will wrap smaller elements.
  factory MeProfileHeader.small({
    Key? key,
    required ProfilesRow profile,
    String? localAssetPath,
  }) {
    return MeProfileHeader(
      key: key,
      minImageSize: 40.0,
      maxImageSize: 60.0,
      minTextSize: 12.0,
      maxTextSize: 20.0,
      profile: profile,
      percentage: 0.3,
      localAssetPath: localAssetPath,
    );
  }

  final double minImageSize;
  final double maxImageSize;
  final double minTextSize;
  final double maxTextSize;

  final ProfilesRow profile;
  final double percentage;
  final Widget? trailing;
  final String? localAssetPath;

  @override
  Widget build(BuildContext context) {
    // Midpoints between min and max
    final midImageSize = (minImageSize + maxImageSize) / 2;
    final midTextSize = (minTextSize + maxTextSize) / 2;

    final imageSize = (midImageSize * percentage).clamp(
      minImageSize,
      maxImageSize,
    );
    final scaledTextSize = lerpDouble(
      minTextSize,
      midTextSize * percentage,
      percentage,
    )!.clamp(minTextSize, maxTextSize);

    final isExpanded = percentage > 0.3;

    final baseNameStyle = Theme.of(context).textTheme.headlineLarge!;
    final scaledNameStyle = baseNameStyle.copyWith(fontSize: scaledTextSize);

    final scaledGradeVStyle = baseNameStyle.copyWith(
      fontSize: scaledTextSize * 0.9,
      fontWeight: FontWeight.bold,
      color: context.colorScheme.primary,
      shadows: [const Shadow(blurRadius: 4, color: Colors.black45)],
    );

    final scaledGradeNumberStyle = baseNameStyle.copyWith(
      fontSize: scaledTextSize * 0.7,
      fontWeight: FontWeight.w500,
      color: context.colorScheme.primary,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ProfileAvatar(
            size: imageSize,
            networkUrl: profile.profileImageUrl,
            localAssetPath: localAssetPath,
          ),
          Gap(Spacing.lg),
          Expanded(
            flex: 5,
            child: Flex(
              direction: isExpanded ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment:
                  isExpanded
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    profile.displayName,
                    style: scaledNameStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                if (!isExpanded) Gap(Spacing.sm),
                Text(
                  profile.climbingLevel ?? "No grade yet",
                  style: scaledGradeVStyle,
                ),
                // RichText(
                //   text: TextSpan(
                //     text: 'V',
                //     style: scaledGradeVStyle,
                //     children: [
                //       TextSpan(text: '3', style: scaledGradeNumberStyle),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          if (isExpanded) trailing ?? const SizedBox.shrink(),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
