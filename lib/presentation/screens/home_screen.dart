import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/video_model.dart';
import '../../logic/bloc/video_bloc.dart';
import '../utils/constraints.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text.dart';
import '../widgets/fetch_error_text.dart';
import '../widgets/loading_widget.dart';

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

  // Callback when the user scrolls
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Load more data when the user is near the end of the list
    if (maxScroll - currentScroll <= 200.0) {
      context.read<VideoBloc>().add(VideoEventGetAllVideo());

      // Scroll to the last item
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.read<VideoBloc>();
    if (videoBloc.videoModel == null) {
      print('recall because of video-model is NULL');
      //videoBloc.add(VideoEventGetAllVideo());
    } else {
      print('video-model is NOT-NULL');
    }
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Trending Video', color: whiteColor),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoStateLoading) {
            //return const LoadingWidget();
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
          } else if (state is VideoStateLoaded) {
            return VideoLoadedWidget(
                videoModel: videoBloc.videoModel!,
                scrollController: _scrollController);
          } else if (state is VideoStateLoadedMore) {
            print('length ${state.videoModel.results!.length}');
            return VideoLoadedWidget(
                videoModel: videoBloc.videoModel!,
                scrollController: _scrollController);
          }
          if (videoBloc.videoModel != null) {
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
    return ListView.builder(
      controller: scrollController,
      itemCount: videoModel.results!.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final title = videoModel.results![index];
        return Column(
          children: [
            CustomImage(path: title.channelImage),
            Row(
              children: [
                CustomText(
                  text: title.id.toString(),
                  fontSize: 20.0,
                  color: redColor,
                ),
                Flexible(child: CustomText(text: title.title)),
              ],
            ),
          ],
        );
      },
    );
  }
}
