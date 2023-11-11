import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../presentation/errors/network_parser.dart';
import 'remote_urls.dart';

abstract class RemoteDataSource {
  Future getAllVideos(String offset);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  final xContentAccept = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future getAllVideos(String offset) async {
    final url = Uri.parse(RemoteUrls.trendingVideos(offset));
    debugPrint('video-url $url');
    final headers = xContentAccept;
    final clientMethod = client.get(url, headers: headers);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseBody;
  }
}
