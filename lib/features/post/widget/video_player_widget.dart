// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnail;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.thumbnail,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;

  static VideoPlayerController? _activeController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setVolume(_isMuted ? 0.0 : 1.0)
      //  ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        if (_controller.value.hasError) {
          debugPrint('Video error: ${_controller.value.errorDescription}');
        }
      });
  }

  void _handleVisibility(double visibleFraction) {
    final shouldPlay = visibleFraction >= 0.9;

    if (shouldPlay) {
      _pauseOthers();
      _controller.play();
      _activeController = _controller;
    } else {
      _controller.pause();
    }

    if (mounted) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  void _pauseOthers() {
    if (_activeController != null && _activeController != _controller) {
      _activeController!.pause();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _fastForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _pauseOthers();
      _controller.play();
      _activeController = _controller;
    }

    setState(() {
      _isPlaying = !_controller.value.isPlaying;
    });
  }

  @override
  void dispose() {
    // Dispose the controller
    // and remove it from the active controller if it's the current one
    if (_activeController == _controller) {
      _activeController = null;
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (visibilityInfo) {
        final visibleFraction = visibilityInfo.visibleFraction;
        _handleVisibility(visibleFraction);
      },
      child: AspectRatio(
        aspectRatio: _controller.value.isInitialized
            ? _controller.value.aspectRatio
            : 16 / 9,
        child: Stack(
          children: [
            _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : (widget.thumbnail != null
                    ? Image.network(widget.thumbnail!, fit: BoxFit.fill)
                    : const Center(
                        child: CircularProgressIndicator(
                        color: Colors.red,
                      ))),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    if (!_controller.value.isInitialized) {
      return Container(); // No controls when video is not initialized
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: _togglePlayPause,
            ),
            IconButton(
              icon: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
                size: 32,
              ),
              onPressed: _toggleMute,
            ),
            IconButton(
              icon: const Icon(
                Icons.fast_forward,
                color: Colors.white,
                size: 32,
              ),
              onPressed: _fastForward,
            ),
          ],
        ),
      ),
    );
  }
}
