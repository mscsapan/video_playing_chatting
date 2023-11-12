import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'data/data_provider/remote_data_source.dart';
import 'logic/bloc/video/video_bloc.dart';
import 'logic/cubit/video_play/video_play_cubit.dart';
import 'logic/repository/video_repository.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<VideoRepository>(
      create: (context) => VideoRepositoryImpl(
        remoteDataSource: context.read(),
      ),
    ),
  ];
  static final blocProviders = <BlocProvider>[
    BlocProvider<VideoBloc>(
      create: (context) => VideoBloc(
        videoRepository: context.read(),
      ),
    ),
    BlocProvider<VideoPlayCubit>(
      create: (context) => VideoPlayCubit(),
    ),
  ];
}
