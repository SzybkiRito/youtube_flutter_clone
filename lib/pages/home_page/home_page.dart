import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/api/connections/videos_connection.dart';
import 'package:youtube_clone/api/dto/youtube_video_dto.dart';
import 'package:youtube_clone/classess/Colors.dart';
import 'package:youtube_clone/classess/string_format.dart';
import 'package:youtube_clone/custom_widgets/bars/preferences_bar.dart';
import 'package:youtube_clone/custom_widgets/bars/shimmers/preferences_bar_shimmer.dart';
import 'package:youtube_clone/pages/home_page/widgets/shimmers/video_shimmer.dart';
import 'package:youtube_clone/pages/home_page/widgets/video_item.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/watch_video_engine_page.dart';
import 'package:youtube_clone/providers/search_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  VideosConnection videosConnection = GetIt.I<VideosConnection>();
  ValueNotifier<String?> nextPageToken = ValueNotifier(null);
  late Future<List<YoutubeVideoDto>> videosList;
  bool isNetworkImageLoaded = false;

  void updateVideoList() {
    videosList.then((videosListResult) async {
      List<YoutubeVideoDto> videos = await videosConnection.getVideosList(nextPageToken: nextPageToken);
      setState(() {
        videosListResult.addAll(videos);
      });
    });
  }

  void updateSearchedVideoList() {
    videosList.then((videosListResult) async {
      List<YoutubeVideoDto> videos = await videosConnection.getSearchedVideos(
        searchInput: Provider.of<SearchProvider>(context, listen: false).searchQuery,
        nextPageToken: nextPageToken,
      );
      setState(() {
        videosListResult.addAll(videos);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (Provider.of<SearchProvider>(context, listen: false).searchQuery != "") {
      videosList = videosConnection.getSearchedVideos(
        searchInput: Provider.of<SearchProvider>(context, listen: false).searchQuery,
        nextPageToken: nextPageToken,
      );
    } else {
      videosList = videosConnection.getVideosList(
        nextPageToken: nextPageToken,
      );
    }

    _scrollController.addListener(() {
      bool limit = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8;
      if (nextPageToken.value != null && limit) {
        if (Provider.of<SearchProvider>(context, listen: false).searchQuery != "") {
          updateSearchedVideoList();
        } else {
          updateVideoList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (Provider.of<SearchProvider>(context, listen: false).searchQuery != "") {
            Provider.of<SearchProvider>(context, listen: false).setSearchQuery("");
            videosList.then((currentVideosList) {
              setState(() {
                currentVideosList.clear();
                nextPageToken.value = null;

                videosList = videosConnection.getVideosList(
                  nextPageToken: nextPageToken,
                );
              });
            });
            Get.back();
          } else {
            Get.back();
          }
          return Future.value(false);
        },
        child: SingleChildScrollView(
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
          itemCount: videos.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < videos.length) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => WatchVideoEnginePage(
                      videoId: videos[index].id,
                      videoTitle: videos[index].title,
                      videoChannel: videos[index].channelName,
                      channelThumbnail: videos[index].channelImageSrc,
                      channelId: videos[index].channelId,
                      videoViews: StringFormat().formatBigNumbers(videos[index].views),
                      videoUploadDate: videos[index].uploadDate,
                      numberOfLikes: StringFormat().formatBigNumbers(videos[index].numberOfLikes ?? '0'),
                    ),
                    transition: Transition.fade,
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
