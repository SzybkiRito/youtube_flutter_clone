import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/api/dto/youtube_video_comment_dto.dart';
import 'package:youtube_clone/api/services/api_service.dart';

class CommentsConnection {
  Map<String, String> queryParameters = {
    'key': '${dotenv.env['GOOGLE_API_KEY']}',
    'part': 'snippet',
  };

  Future<List<YoutubeVideoCommentDto>> getVideoComments({
    required videoId,
    required ValueNotifier<String?> nextPageToken,
  }) async {
    String url = 'https://www.googleapis.com/youtube/v3/commentThreads';
    queryParameters['pageToken'] = nextPageToken.value ?? '';
    queryParameters['videoId'] = videoId;

    var apiResponse = await ApiService().get(url: url, queryParameters: queryParameters);
    if (apiResponse['items'] != null) {
      List<YoutubeVideoCommentDto> videoComments = [];
      nextPageToken.value = apiResponse['nextPageToken'];
      for (var item in apiResponse['items']) {
        videoComments.add(YoutubeVideoCommentDto.fromJson(item));
      }

      return videoComments;
    }
    return [];
  }
}
