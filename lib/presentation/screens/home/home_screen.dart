import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/video_model.dart';
import '../../../logic/bloc/video/video_bloc.dart';
import '../../../logic/bloc/video/video_event.dart';
import '../../routes/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/fetch_error_text.dart';
import '../../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    Future.microtask(
        () => context.read<VideoBloc>().add(VideoEventGetAllVideo()));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= 200.0) {
      context.read<VideoBloc>().add(VideoEventGetAllVideo());
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.read<VideoBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Trending Video', color: whiteColor),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoStateLoading && videoBloc.initialOffset == 1) {
            return const LoadingWidget();
          } else if (state is VideoStateError) {
            if (state.statusCode == 503) {
              if (videoBloc.videoModel != null) {
                return VideoLoadedWidget(
                    videoModel: videoBloc.videoModel!,
                    scrollController: _scrollController);
              } else {
                return const FetchErrorText(text: 'network problem');
              }
            }
            return FetchErrorText(text: state.message);
          } else if (state is VideoStateLoaded ||
              state is VideoStateLoadedMore) {
            return VideoLoadedWidget(
                videoModel: videoBloc.videoModel!,
                scrollController: _scrollController);
          } else if (videoBloc.videoModel != null) {
            return VideoLoadedWidget(
                videoModel: videoBloc.videoModel!,
                scrollController: _scrollController);
          } else {
            return const FetchErrorText(text: 'Something went wrong');
          }
        },
      ),
    );
  }
}

class VideoLoadedWidget extends StatelessWidget {
  const VideoLoadedWidget(
      {super.key, required this.videoModel, required this.scrollController});

  final VideoModel videoModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    print('totalLength ${videoModel.results!.length}');
    final videoBloc = context.read<VideoBloc>();
    return Container(
      margin: Utils.symmetric(h: 14.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: videoModel.results!.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final title = videoModel.results![index];
                return Padding(
                  padding: Utils.symmetric(h: 0.0, v: 10.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.videoPlayScreen,
                      arguments: title,
                    ),
                    child: Column(
                      children: [
                        CustomImage(path: title.thumbnail),
                        Row(
                          children: [
                            CustomText(
                              text: title.id.toString(),
                              fontSize: 20.0,
                              color: redColor,
                            ),
                            Flexible(
                                child: CustomText(
                                    text: Utils.convertToBangla(title.title))),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoStateLoading) {
                if (videoBloc.initialOffset != 1) {
                  return const LoadingWidget(color: redColor);
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
