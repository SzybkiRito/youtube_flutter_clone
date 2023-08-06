import 'package:flutter/material.dart';
import 'package:youtube_clone/api/dto/youtube_channel_dto.dart';
import 'package:youtube_clone/classess/string_format.dart';
import 'package:youtube_clone/pages/watch_video_engine_page/widgets/shimmers/video_info_shimmer.dart';

class VideoChannelFutureBuilder extends StatefulWidget {
  const VideoChannelFutureBuilder({super.key, required this.channelData});
  final Future<YoutubeChannelDto> channelData;

  @override
  State<VideoChannelFutureBuilder> createState() => _VideoChannelFutureBuilderState();
}

class _VideoChannelFutureBuilderState extends State<VideoChannelFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.channelData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: VideoInfoShimmer());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(snapshot.data!.channelThumbnail),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.name,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      "${StringFormat().formatBigNumbers(snapshot.data!.subscribers)} subscribers",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: VideoInfoShimmer());
        }
      },
    );
  }
}
