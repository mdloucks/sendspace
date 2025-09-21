import 'package:flutter/material.dart';
import 'package:sendspace/core/data/models/dto/tables/posts.dart';
import 'package:video_player/video_player.dart';

class PostDetailPage extends StatefulWidget {
  final PostsRow post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    final url = widget.post.videoUrl;
    if (url != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          setState(() {
            _initialized = true;
          });
          _controller.play();
          _controller.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    if (_initialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video background - fullscreen
          if (_initialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          // Text overlay
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.data['title'] ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (post.data['description'] != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    post.data['description'],
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ],
                if (post.data['grade'] != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    "Grade: ${post.data['grade']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
                if (post.data['created_at'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Posted: ${post.data['created_at']}",
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),

          // Back button overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black38,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
