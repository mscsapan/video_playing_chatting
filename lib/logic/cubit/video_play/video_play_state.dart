part of 'video_play_cubit.dart';

abstract class VideoPlayState extends Equatable {
  const VideoPlayState();

  @override
  List<Object> get props => [];
}

class VideoPlayInitial extends VideoPlayState {}

class VideoPlayLoadingState extends VideoPlayState {}

class VideoPlayLoadedState extends VideoPlayState {
  // final VideoPlayerController controller;
  final CustomVideoPlayerController customVideoPlayerController;

  const VideoPlayLoadedState(this.customVideoPlayerController);

  @override
  List<Object> get props => [customVideoPlayerController];
}

class VideoErrorState extends VideoPlayState {
  final String error;

  const VideoErrorState(this.error);

  @override
  List<Object> get props => [error];
}
