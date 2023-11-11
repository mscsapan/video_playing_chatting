import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'single_video_model.dart';

class VideoModel extends Equatable {
  final int total;
  final int page;
  final int pageSize;
  final List<SingleVideoModel>? results;

  const VideoModel({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.results,
  });

  VideoModel copyWith({
    int? total,
    int? page,
    int? pageSize,
    List<SingleVideoModel>? results,
  }) {
    return VideoModel(
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'page': page,
      'page_size': pageSize,
      'results': results!.map((x) => x.toMap()).toList(),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      total: map['total'] ?? 0,
      page: map['page'] ?? 0,
      pageSize: map['page_size'] ?? 0,
      results: map['results'] != null
          ? List<SingleVideoModel>.from(
              (map['results'] as List<dynamic>).map<SingleVideoModel>(
                (x) => SingleVideoModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [total, page, pageSize, results!];
}
