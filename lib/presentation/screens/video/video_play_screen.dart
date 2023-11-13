import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/single_video_model.dart';
import '../../../logic/cubit/video_play/video_play_cubit.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/fetch_error_text.dart';
import '../../widgets/loading_widget.dart';

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
    final video = widget.videoModel.manifest;
    print('video-url $video');
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: widget.videoModel.channelName),
      ),
      body: video.isNotEmpty
          ? BlocBuilder<VideoPlayCubit, VideoPlayState>(
              builder: (context, state) {
                if (state is VideoPlayLoadingState) {
                  return const LoadingWidget();
                } else if (state is VideoPlayLoadedState) {
                  return CustomVideoPlayer(
                    customVideoPlayerController:
                        state.customVideoPlayerController,
                  );
                } else if (state is VideoErrorState) {
                  return FetchErrorText(text: state.error);
                }

                return const Center(child: Text('Something went wrong.'));
              },
            )
          : const CustomText(text: 'No Video URL found'),
    );
  }
}
