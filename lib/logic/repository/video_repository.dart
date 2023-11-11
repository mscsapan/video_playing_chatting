import 'package:dartz/dartz.dart';

import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/video_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class VideoRepository {
  Future<Either<Failure, VideoModel>> getAllVideos(String offset);
}

class VideoRepositoryImpl implements VideoRepository {
  final RemoteDataSource remoteDataSource;

  const VideoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, VideoModel>> getAllVideos(String offset) async {
    try {
      final result = await remoteDataSource.getAllVideos(offset);
      final video = VideoModel.fromMap(result);
      return Right(video);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
