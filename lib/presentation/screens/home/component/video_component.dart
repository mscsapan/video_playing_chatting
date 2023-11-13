import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/single_video_model.dart';
import '../../../../logic/bloc/video/video_bloc.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_text.dart';

class VideoComponent extends StatelessWidget {
  const VideoComponent({super.key, required this.title});

  final SingleVideoModel title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final videoCubit = context.read<VideoBloc>().videoModel;
    return Column(
      children: [
        Stack(
          children: [
            Container(
                height: Utils.vSize(192.0),
                margin: Utils.only(bottom: 16.0),
                width: size.width,
                child: CustomImage(
                  path: title.thumbnail.isNotEmpty
                      ? title.thumbnail
                      : videoCubit!.results!.first.thumbnail,
                  fit: BoxFit.cover,
                )),
            Positioned(
              right: 10.0,
              bottom: 24.0,
              child: Container(
                padding: Utils.symmetric(h: 4.0, v: 2.0),
                decoration: BoxDecoration(
                  color: blackColor,
                  borderRadius: Utils.borderRadius(r: 2.0),
                ),
                child: CustomText(
                  text: title.duration,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: Utils.symmetric(h: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: Utils.vSize(40.0),
                        width: Utils.vSize(40.0),
                        margin: Utils.only(right: 12.0),
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(r: 20.0),
                          child: CustomImage(
                            path: title.channelImage,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomText(
                        text: Utils.convertToBangla(title.title),
                        maxLine: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: Color(0xFFD9D9D9),
              )
            ],
          ),
        ),
        Padding(
          padding: Utils.only(left: 60.0, top: 6.0),
          child: Row(
            children: [
              CustomText(
                text: '${title.viewers.padLeft(2, '0')} views',
                fontSize: 13.0,
                color: const Color(0xFF718096),
              ),
              Container(
                height: 3.0,
                width: 3.0,
                alignment: Alignment.bottomCenter,
                margin: Utils.symmetric(h: 6.0, v: 6.0).copyWith(bottom: 0.0),
                decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
              CustomText(
                text: Utils.convertTime(title.createdAt),
                fontSize: 13.0,
                color: const Color(0xFF718096),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
