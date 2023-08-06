import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/api/dto/youtube_video_dto.dart';
import 'package:youtube_clone/api/services/api_service.dart';

class VideosConnection {
  Map<String, String> queryParameters = {
    'key': '${dotenv.env['GOOGLE_API_KEY']}',
    'part': 'snippet,contentDetails,statistics,topicDetails',
    'chart': 'mostPopular',
    'regionCode': 'PL',
  };

  Future<List<YoutubeVideoDto>> getVideosList({required ValueNotifier<String?> nextPageToken}) async {
    String url = 'https://www.googleapis.com/youtube/v3/videos';
    queryParameters['pageToken'] = nextPageToken.value ?? '';

    var apiResponse = await ApiService().get(url: url, queryParameters: queryParameters);
    if (apiResponse['items'] != null) {
      List<YoutubeVideoDto> videosList = [];
      nextPageToken.value = apiResponse['nextPageToken'];
      for (var item in apiResponse['items']) {
        videosList.add(YoutubeVideoDto.fromJson(item));
      }
      return videosList;
    }
    return [];
  }
}
