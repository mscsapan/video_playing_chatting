import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleVideoModel extends Equatable {
  final String thumbnail;
  final int id;
  final String title;
  final String dateAndTime;
  final String slug;
  final String createdAt;
  final String manifest;
  final int liveStatus;
  final String liveManifest;
  final bool isLive;
  final String channelImage;
  final String channelName;
  final bool isVerified;
  final String channelSlug;
  final String channelSubscriber;
  final int channelId;
  final String type;
  final String viewers;
  final String duration;

  const SingleVideoModel({
    required this.thumbnail,
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.slug,
    required this.createdAt,
    required this.manifest,
    required this.liveStatus,
    required this.liveManifest,
    required this.isLive,
    required this.channelImage,
    required this.channelName,
    required this.isVerified,
    required this.channelSlug,
    required this.channelSubscriber,
    required this.channelId,
    required this.type,
    required this.viewers,
    required this.duration,
  });

  SingleVideoModel copyWith({
    String? thumbnail,
    int? id,
    String? title,
    String? dateAndTime,
    String? slug,
    String? createdAt,
    String? manifest,
    int? liveStatus,
    String? liveManifest,
    bool? isLive,
    String? channelImage,
    String? channelName,
    bool? isVerified,
    String? channelSlug,
    String? channelSubscriber,
    int? channelId,
    String? type,
    String? viewers,
    String? duration,
  }) {
    return SingleVideoModel(
      thumbnail: thumbnail ?? this.thumbnail,
      id: id ?? this.id,
      title: title ?? this.title,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      manifest: manifest ?? this.manifest,
      liveStatus: liveStatus ?? this.liveStatus,
      liveManifest: liveManifest ?? this.liveManifest,
      isLive: isLive ?? this.isLive,
      channelImage: channelImage ?? this.channelImage,
      channelName: channelName ?? this.channelName,
      isVerified: isVerified ?? this.isVerified,
      channelSlug: channelSlug ?? this.channelSlug,
      channelSubscriber: channelSubscriber ?? this.channelSubscriber,
      channelId: channelId ?? this.channelId,
      type: type ?? this.type,
      viewers: viewers ?? this.viewers,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thumbnail': thumbnail,
      'id': id,
      'title': title,
      'date_and_time': dateAndTime,
      'slug': slug,
      'created_at': createdAt,
      'manifest': manifest,
      'live_status': liveStatus,
      'live_manifest': liveManifest,
      'is_live': isLive,
      'channel_image': channelImage,
      'channel_name': channelName,
      'is_verified': isVerified,
      'channel_slug': channelSlug,
      'channel_subscriber': channelSubscriber,
      'channel_id': channelId,
      'type': type,
      'viewers': viewers,
      'duration': duration,
    };
  }

  factory SingleVideoModel.fromMap(Map<String, dynamic> map) {
    return SingleVideoModel(
      thumbnail: map['thumbnail'] ?? '',
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      dateAndTime: map['date_and_time'] ?? '',
      slug: map['slug'] ?? '',
      createdAt: map['created_at'] ?? '',
      manifest: map['manifest'] ?? '',
      liveStatus: map['live_status'] ?? 0,
      liveManifest: map['live_manifest'] ?? '',
      isLive: map['is_live'] ?? false,
      channelImage: map['channel_image'] ?? '',
      channelName: map['channel_name'] ?? '',
      isVerified: map['is_verified'] ?? false,
      channelSlug: map['channel_slug'] ?? '',
      channelSubscriber: map['channel_subscriber'] ?? '',
      channelId: map['channel_id'] ?? 0,
      type: map['type'] ?? '',
      viewers: map['viewers'] ?? '',
      duration: map['duration'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleVideoModel.fromJson(String source) =>
      SingleVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      thumbnail,
      id,
      title,
      dateAndTime,
      slug,
      createdAt,
      manifest,
      liveStatus,
      liveManifest,
      isLive,
      channelImage,
      channelName,
      isVerified,
      channelSlug,
      channelSubscriber,
      channelId,
      type,
      viewers,
      duration,
    ];
  }
}
