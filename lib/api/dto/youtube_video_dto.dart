import 'package:youtube_clone/classess/date.dart';

class YoutubeVideoDto {
  final String id;
  final String title;
  final String channelName;
  final String videoDescription;
  final String views;
  final String uploadDate;
  final String duration;
  final String miniatureImageSrc;
  final String channelImageSrc;
  final String channelId;
  final String? numberOfLikes;

  YoutubeVideoDto({
    required this.id,
    required this.title,
    required this.channelName,
    required this.videoDescription,
    required this.views,
    required this.uploadDate,
    required this.duration,
    required this.miniatureImageSrc,
    required this.channelImageSrc,
    required this.channelId,
    this.numberOfLikes,
  });

  factory YoutubeVideoDto.fromJson(Map<String, dynamic> json) {
    String uploadDate = json['snippet']['publishedAt'];
    DateTime uploadDateDateTime = DateTime.parse(uploadDate);
    DateTime now = DateTime.now();
    Duration dateDifference = now.difference(uploadDateDateTime);
    String duration = Date().formatDuration(json['contentDetails']['duration']);

    return YoutubeVideoDto(
      id: json['id'],
      title: json['snippet']['title'],
      channelName: json['snippet']['channelTitle'],
      videoDescription: json['snippet']['description'],
      views: json['statistics']['viewCount'],
      uploadDate: Date().formatDateToTimeAgo(dateDifference),
      duration: duration,
      miniatureImageSrc: json['snippet']['thumbnails']['high']['url'],
      channelImageSrc: json['snippet']['thumbnails']['high']['url'],
      channelId: json['snippet']['channelId'],
      numberOfLikes: json['statistics']['likeCount'] ?? '',
    );
  }
}
