import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

import '../../../data/models/single_video_model.dart';
import '../../../logic/cubit/video_play/video_play_cubit.dart';
import '../../widgets/custom_text.dart';

// class VideoPlayScreen extends StatefulWidget {
//   const VideoPlayScreen({super.key, required this.videoModel});
//
//   final SingleVideoModel videoModel;
//
//   @override
//   State<VideoPlayScreen> createState() => _VideoPlayScreenState();
// }
//
// class _VideoPlayScreenState extends State<VideoPlayScreen> {
//   late CustomVideoPlayerController _customVideoPlayerController;
//   late VideoPlayerController _videoPlayerController;
//
//   void initVideoController() {
//     final video = Uri.parse(widget.videoModel.manifest);
//     _videoPlayerController = VideoPlayerController.networkUrl(video)
//       ..initialize().then((value) {
//         setState(() {});
//         debugPrint('initializing video');
//       });
//     _customVideoPlayerController = CustomVideoPlayerController(
//         context: context, videoPlayerController: _videoPlayerController);
//   }
//
//   @override
//   void initState() {
//     initVideoController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _customVideoPlayerController.dispose();
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('video-url ${widget.videoModel.manifest}');
//     return Scaffold(
//       appBar: AppBar(
//         title: CustomText(text: widget.videoModel.channelName),
//       ),
//       body: CustomVideoPlayer(
//         customVideoPlayerController: _customVideoPlayerController,
//       ),
//     );
//   }
// }

// video_play_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({super.key, required this.videoModel});

  final SingleVideoModel videoModel;

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  @override
  void initState() {
    if (widget.videoModel.manifest.isNotEmpty) {
      Future.microtask(() => context
          .read<VideoPlayCubit>()
          .initializeVideo(context, widget.videoModel.manifest));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('video-url ${widget.videoModel.manifest}');
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: widget.videoModel.channelName),
      ),
      body: BlocBuilder<VideoPlayCubit, VideoPlayState>(
        builder: (context, state) {
          if (state is VideoPlayLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoPlayLoadedState) {
            return CustomVideoPlayer(
              customVideoPlayerController: state.customVideoPlayerController,
            );
          } else if (state is VideoErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
