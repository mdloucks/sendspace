import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sendspace/core/data/dto/tables/profiles.dart';
import 'package:sendspace/core/extensions/build_context.dart';
import 'package:sendspace/features/me/presentation/views/settings_page.dart';
import 'package:sendspace/features/me/presentation/widgets/me_profile_header.dart';

class MeAppBar extends StatelessWidget {
  final ProfilesRow profile;

  const MeAppBar({super.key, required this.profile});

  static const double _maxSliverHeight = 200;
  static const double _minSliverHeight = 88;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.textScalerOf(context).scale(1);

    final sliverHeight =
        _maxSliverHeight * textScaleFactor * 0.3 + _maxSliverHeight * 0.7;

    return SliverAppBar(
      pinned: true,
      expandedHeight: sliverHeight,
      surfaceTintColor: Colors.transparent,
      backgroundColor: context.colorScheme.surface,
      collapsedHeight: _minSliverHeight,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = sliverHeight;
          double percentage = constraints.maxHeight / maxHeight;
          percentage = pow(percentage, 3).toDouble();
          percentage = percentage.clamp(0.0, 1.0);

          return Stack(
            children: [
              Container(),
              MeProfileHeader(
                minTextSize: context.textTheme.titleLarge?.fontSize ?? 16,
                maxTextSize: context.textTheme.headlineLarge?.fontSize ?? 32,
                minImageSize: 64,
                maxImageSize: 144,
                profile: profile,
                percentage: percentage,
                trailing: GestureDetector(
                  child: const Icon(Icons.settings_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),

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
                      // TODO: These overflow when text is scaled up a ton. I don't have
                      // an easy fix in mind besides hiding one of them.
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

  // Helper widget for the data points
  Widget _buildDataPoint(String label, int value) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
