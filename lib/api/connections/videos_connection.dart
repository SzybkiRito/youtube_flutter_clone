import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/api/dto/youtube_video_dto.dart';
import 'package:youtube_clone/api/services/api_service.dart';

class VideosConnection {
  Future<List<YoutubeVideoDto>> getVideosList({required ValueNotifier<String?> nextPageToken}) async {
    String url = 'https://www.googleapis.com/youtube/v3/videos';
    Map<String, String> queryParameters = {
      'key': '${dotenv.env['GOOGLE_API_KEY']}',
      'part': 'snippet,contentDetails,statistics,topicDetails',
      'pageToken': nextPageToken.value ?? '',
      'chart': 'mostPopular',
    };

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

  Future<YoutubeVideoDto> getVideoById({required videoId}) async {
    String url = 'https://www.googleapis.com/youtube/v3/videos';
    Map<String, String> queryParameters = {
      'key': '${dotenv.env['GOOGLE_API_KEY']}',
      'part': 'snippet,contentDetails,statistics,topicDetails',
      'id': videoId,
    };

    var apiResponse = await ApiService().get(url: url, queryParameters: queryParameters);
    if (apiResponse['items'] != null) {
      return YoutubeVideoDto.fromJson(apiResponse['items'][0]);
    }

    return YoutubeVideoDto(
      id: '',
      title: '',
      channelName: '',
      videoDescription: '',
      views: '',
      uploadDate: '',
      duration: '',
      miniatureImageSrc: '',
      channelImageSrc: '',
      channelId: '',
      numberOfLikes: '',
    );
  }

  Future<List<YoutubeVideoDto>> getSearchedVideos({
    required String searchInput,
    required ValueNotifier<String?> nextPageToken,
  }) async {
    String url = 'https://www.googleapis.com/youtube/v3/search';
    Map<String, String> queryParameters = {
      'key': '${dotenv.env['GOOGLE_API_KEY']}',
      'part': 'snippet',
      'pageToken': nextPageToken.value ?? '',
      'q': searchInput,
    };

    var apiResponse = await ApiService().get(url: url, queryParameters: queryParameters);
    nextPageToken.value = apiResponse['nextPageToken'];
    if (apiResponse['items'] != null) {
      List<YoutubeVideoDto> videosList = [];
      for (var item in apiResponse['items']) {
        videosList.add(
          await getVideoById(videoId: item['id']['videoId']),
        );
      }
      return videosList;
    }

    return [];
  }
}
