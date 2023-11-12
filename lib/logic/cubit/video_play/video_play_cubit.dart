import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_play_state.dart';

class VideoPlayCubit extends Cubit<VideoPlayState> {
  VideoPlayCubit() : super(VideoPlayInitial());

  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  Future<void> initializeVideo(BuildContext context, String videoUrl) async {
    emit(VideoPlayLoadingState());
    final url = Uri.parse(videoUrl);
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(url);
      await _videoPlayerController.initialize();

      _customVideoPlayerController = CustomVideoPlayerController(
          context: context, videoPlayerController: _videoPlayerController);

      emit(VideoPlayLoadedState(_customVideoPlayerController));
    } catch (e) {
      emit(VideoErrorState('Error initializing video: $e'));
    }
  }
}
