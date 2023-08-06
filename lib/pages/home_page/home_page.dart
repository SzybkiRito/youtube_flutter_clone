import 'package:flutter/material.dart';
import 'package:youtube_clone/api/connections/videos_connection.dart';
import 'package:youtube_clone/api/dto/youtube_video_dto.dart';
import 'package:youtube_clone/classess/Colors.dart';
import 'package:youtube_clone/classess/string_format.dart';
import 'package:youtube_clone/custom_widgets/bars/preferences_bar.dart';
import 'package:youtube_clone/custom_widgets/bars/shimmers/preferences_bar_shimmer.dart';
import 'package:youtube_clone/pages/home_page/widgets/shimmers/video_shimmer.dart';
import 'package:youtube_clone/pages/home_page/widgets/video_item.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/watch_video_engine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<String?> nextPageToken = ValueNotifier(null);
  late Future<List<YoutubeVideoDto>> videosList;
  bool isNetworkImageLoaded = false;

  void updateVideoList() {
    videosList.then((videosListResult) async {
      List<YoutubeVideoDto> videos = await VideosConnection().getVideosList(nextPageToken: nextPageToken);
      videosListResult.addAll(videos);
    });
  }

  @override
  void initState() {
    super.initState();
    videosList = VideosConnection().getVideosList(nextPageToken: nextPageToken);

    _scrollController.addListener(() {
      bool limit = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent;
      if (nextPageToken.value != null && limit) {
        setState(() {
          updateVideoList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: FutureBuilder(
          future: videosList,
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const PreferencesBarShimmer(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return const VideoShimmer();
                      },
                    ),
                  ],
                );
              case ConnectionState.waiting:
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const PreferencesBarShimmer(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return const VideoShimmer();
                      },
                    ),
                  ],
                );
              case ConnectionState.done:
                return buildVideosList(snapshot.data!);
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget buildVideosList(List<YoutubeVideoDto> videos) {
    return Column(
      children: [
        const PreferencesBar(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < videos.length - 1) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WatchVideoEnginePage(
                        videoId: videos[index].id,
                        videoTitle: videos[index].title,
                        videoChannel: videos[index].channelName,
                        channelThumbnail: videos[index].channelImageSrc,
                        channelId: videos[index].channelId,
                        videoViews: StringFormat().formatBigNumbers(videos[index].views),
                        videoUploadDate: videos[index].uploadDate,
                        numberOfLikes: StringFormat().formatBigNumbers(videos[index].numberOfLikes),
                      ),
                    ),
                  );
                },
                child: VideoItem(
                  channelImageSrc: videos[index].channelImageSrc,
                  channelName: videos[index].channelName,
                  duration: videos[index].duration,
                  miniatureImageSrc: videos[index].miniatureImageSrc,
                  title: videos[index].title,
                  uploadDate: videos[index].uploadDate,
                  views: StringFormat().formatBigNumbers(videos[index].views),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
