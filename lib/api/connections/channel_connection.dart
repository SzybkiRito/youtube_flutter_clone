import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/api/dto/youtube_channel_dto.dart';
import 'package:youtube_clone/api/services/api_service.dart';

class ChannelConnection {
  Map<String, String> queryParameters = {
    'key': '${dotenv.env['GOOGLE_API_KEY']}',
    'part': 'snippet,statistics',
  };

  Future<YoutubeChannelDto> getChannelData({required String channelId}) async {
    String url = 'https://www.googleapis.com/youtube/v3/channels';
    queryParameters['id'] = channelId;

    try {
      var apiResponse = await ApiService().get(url: url, queryParameters: queryParameters);
      if (apiResponse['items'] != null) {
        YoutubeChannelDto channelData = YoutubeChannelDto.fromJson(apiResponse['items'][0]);

        return channelData;
      }
    } catch (e) {
      throw Exception(e);
    }

    return YoutubeChannelDto(
      channelThumbnail: '',
      id: '',
      name: '',
      subscribers: '',
    );
  }
}
