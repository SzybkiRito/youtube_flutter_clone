class YoutubeVideoCommentDto {
  String id;
  String author;
  String authorImage;
  String text;
  String publishedAt;
  String likeCount;
  String replyCount;

  YoutubeVideoCommentDto({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.text,
    required this.publishedAt,
    required this.likeCount,
    required this.replyCount,
  });

  factory YoutubeVideoCommentDto.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoCommentDto(
      id: json['id'],
      author: json['snippet']['topLevelComment']['snippet']['authorDisplayName'],
      authorImage: json['snippet']['topLevelComment']['snippet']['authorProfileImageUrl'],
      text: json['snippet']['topLevelComment']['snippet']['textDisplay'],
      publishedAt: json['snippet']['topLevelComment']['snippet']['publishedAt'],
      likeCount: json['snippet']['topLevelComment']['snippet']['likeCount'].toString(),
      replyCount: json['snippet']['totalReplyCount'].toString(),
    );
  }
}
