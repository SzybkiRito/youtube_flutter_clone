class YoutubeChannelDto {
  final String id;
  final String name;
  final String channelThumbnail;
  final String subscribers;

  YoutubeChannelDto({
    required this.id,
    required this.name,
    required this.channelThumbnail,
    required this.subscribers,
  });

  factory YoutubeChannelDto.fromJson(Map<String, dynamic> json) {
    return YoutubeChannelDto(
      id: json['id'],
      name: json['snippet']['title'],
      channelThumbnail: json['snippet']['thumbnails']['high']['url'],
      subscribers: json['statistics']['subscriberCount'],
    );
  }
}
