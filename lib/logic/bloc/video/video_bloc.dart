import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/video_model.dart';
import '../../repository/video_repository.dart';
import 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;

  VideoBloc({required VideoRepository videoRepository})
      : _videoRepository = videoRepository,
        super(VideoStateInitial()) {
    on<VideoEventGetAllVideo>(_getAllVideo);
  }

  VideoModel? videoModel;
  int initialOffset = 1;

  Future<void> _getAllVideo(
      VideoEventGetAllVideo event, Emitter<VideoState> emit) async {
    print('initialOffset $initialOffset');
    emit(VideoStateLoading());
    final result =
        await _videoRepository.getAllVideos(initialOffset.toString());
    result.fold((failure) {
      emit(VideoStateError(failure.message, failure.statusCode));
    }, (success) {
      if (videoModel == null) {
        videoModel = success;
        emit(VideoStateLoaded(success));
      } else {
        videoModel!.results!.addAll(success.results!);
        emit(VideoStateLoadedMore(videoModel!));
      }
      initialOffset++;
    });
  }
}
