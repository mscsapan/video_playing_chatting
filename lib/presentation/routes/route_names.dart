import 'package:flutter/material.dart';

import '../../data/models/single_video_model.dart';
import '../screens/home/home_screen.dart';
import '../screens/video/video_play_screen.dart';

class RouteNames {
  static const String homeScreen = '/homeScreen';
  static const String videoPlayScreen = '/videoPlayScreen';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.videoPlayScreen:
        final videoModel = settings.arguments as SingleVideoModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoPlayScreen(videoModel: videoModel));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Found ${settings.name}'),
            ),
          ),
        );
    }
  }
}
