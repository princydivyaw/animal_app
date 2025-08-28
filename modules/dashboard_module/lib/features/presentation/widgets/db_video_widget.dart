import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  bool isInitialized = false;
  bool showControls = false;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() => isInitialized = true);
          controller
            ..setLooping(true)
            ..setVolume(0)
            ..play();
        }
      }).catchError((error) {
        debugPrint("Video load failed: $error");
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: Stack(
        children: [
          VideoPlayer(controller),
          Positioned(
            left: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  isMuted = !isMuted;
                  controller.setVolume(isMuted ? 0.0 : 1.0);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.backgroundDark,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  size: 24,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),
          if (showControls)
            Align(
              alignment: Alignment.center,
              child: IconButton(
                iconSize: 64,
                color: AppColors.surface,
                icon: Icon(
                  controller.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                ),
                onPressed: () {
                  setState(() {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
