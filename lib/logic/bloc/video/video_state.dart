part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoStateInitial extends VideoState {}

class VideoStateLoading extends VideoState {}

class VideoStateLoaded extends VideoState {
  final VideoModel videoModel;

  const VideoStateLoaded(this.videoModel);

  @override
  List<Object> get props => [videoModel];
}

class VideoStateLoadedMore extends VideoState {
  final VideoModel videoModel;

  const VideoStateLoadedMore(this.videoModel);

  @override
  List<Object> get props => [videoModel];
}

class VideoStateError extends VideoState {
  final String message;
  final int statusCode;

  const VideoStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
