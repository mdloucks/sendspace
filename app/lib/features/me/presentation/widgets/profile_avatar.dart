import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? networkUrl;
  final String? localAssetPath;
  final double size;

  const ProfileAvatar({
    super.key,
    this.networkUrl,
    this.localAssetPath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (localAssetPath != null && localAssetPath!.isNotEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: AssetImage(localAssetPath!),
      );
    } else if (networkUrl != null && networkUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(networkUrl!),
      );
    } else {
      return CircleAvatar(
        radius: size / 2,
        //TODO: come up with actual fallback
        backgroundImage: const AssetImage("assets/images/default_avatar.png"),
      );
    }
  }
}
