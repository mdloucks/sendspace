import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

mixin VideoMixin {
  String get thumbnailImageFormat => 'jpeg';

  Future<int> getVideoDurationInMilliseconds(File videoFile) async {
    final controller = VideoPlayerController.file(videoFile);
    await controller.initialize();
    final duration = controller.value.duration;
    await controller.dispose();
    return duration.inMilliseconds;
  }

  Future<Uint8List?> generateThumbnailFromVideo(File videoFile) async {
    if (!await videoFile.exists()) {
      throw FileNotFoundError();
    }

    try {
      final halfwayThroughVideo =
          (await getVideoDurationInMilliseconds(videoFile) / 2).toInt();
      final uint8list = await VideoCompress.getByteThumbnail(
        videoFile.path,
        quality: 50,
        position: halfwayThroughVideo,
      );
      return uint8list;
    } catch (e, st) {
      rethrow;
    }
  }
}
