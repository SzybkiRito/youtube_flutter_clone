import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_clone/api/connections/channel_connection.dart';
import 'package:youtube_clone/api/connections/comments_connection.dart';
import 'package:youtube_clone/api/dto/youtube_channel_dto.dart';
import 'package:youtube_clone/api/dto/youtube_video_comment_dto.dart';
import 'package:youtube_clone/classess/colors.dart';
import 'package:youtube_clone/classess/date.dart';
import 'package:youtube_clone/classess/string_format.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/widgets/shimmers/video_comment_shimmer.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/widgets/video_channel_future_builder.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/widgets/video_comment.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/widgets/video_info.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WatchVideoEnginePage extends StatefulWidget {
  const WatchVideoEnginePage({
    super.key,
    required this.videoId,
    required this.videoTitle,
    required this.videoChannel,
    required this.channelThumbnail,
    required this.channelId,
    required this.videoViews,
    required this.videoUploadDate,
    required this.numberOfLikes,
  });
  final String videoId;
  final String videoTitle;
  final String videoChannel;
  final String channelThumbnail;
  final String channelId;
  final String videoViews;
  final String videoUploadDate;
  final String numberOfLikes;

  @override
  State<WatchVideoEnginePage> createState() => _WatchVideoEnginePageState();
}

class _WatchVideoEnginePageState extends State<WatchVideoEnginePage> {
  ValueNotifier<String?> nextPageToken = ValueNotifier(null); // Comments Pagination
  final ScrollController _scrollController = ScrollController();
  late Future<YoutubeChannelDto> channelData;
  late Future<List<YoutubeVideoCommentDto>> videoComments;
  final _iFrameController = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  void setVideoComments(String videoId, ValueNotifier<String?> nextPageToken) {
    videoComments = CommentsConnection().getVideoComments(videoId: widget.videoId, nextPageToken: nextPageToken);
  }

  void updateVideoComments(String videoId, ValueNotifier<String?> nextPageToke) {
    videoComments.then((videosListResult) async {
      List<YoutubeVideoCommentDto> videos = await CommentsConnection().getVideoComments(
        videoId: widget.videoId,
        nextPageToken: nextPageToken,
      );
      videosListResult.addAll(videos);
    });
  }

  @override
  void initState() {
    super.initState();
    _iFrameController.loadVideoById(videoId: widget.videoId);
    channelData = ChannelConnection().getChannelData(channelId: widget.channelId);
    setVideoComments(
      widget.videoId,
      nextPageToken,
    );

    _scrollController.addListener(() {
      bool limit = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent;
      if (nextPageToken.value != null && limit) {
        setState(() {
          updateVideoComments(
            widget.videoId,
            nextPageToken,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _iFrameController,
              aspectRatio: 16 / 9,
            ),
            VideoInfo(
              videoTitle: widget.videoTitle,
              videoViews: widget.videoViews,
              videoUploadDate: widget.videoUploadDate,
              numberOfLikes: widget.numberOfLikes,
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: YoutubeColors().shimmerHighlightColor,
            ),
            VideoChannelFutureBuilder(channelData: channelData),
            Container(
              height: 1,
              color: YoutubeColors().shimmerHighlightColor,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Comments',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            FutureBuilder(
              future: videoComments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const Center(child: VideoCommentShimmer());
                      },
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Flexible(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (index < snapshot.data!.length - 1) {
                          String uploadDate = snapshot.data![index].publishedAt;
                          DateTime uploadDateDateTime = DateTime.parse(uploadDate);
                          DateTime now = DateTime.now();
                          Duration dateDifference = now.difference(uploadDateDateTime);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: VideoComment(
                              author: snapshot.data![index].author,
                              authorThumbnail: snapshot.data![index].authorImage,
                              text: snapshot.data![index].text,
                              likes: snapshot.data![index].likeCount,
                              publishedAt: Date().formatDateToTimeAgo(dateDifference),
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  );
                } else {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const Center(child: VideoCommentShimmer());
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
