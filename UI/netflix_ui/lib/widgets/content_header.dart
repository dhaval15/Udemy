import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:video_player/video_player.dart';

import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: mobileContentHeader(),
      desktop: DesktopContentHeader(featuredContent: featuredContent),
    );
  }

  Widget mobileContentHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticleIconButton(
                icon: Icons.add,
                title: 'List',
              ),
              PlayButton(),
              VerticleIconButton(
                icon: Icons.info,
                title: 'Info',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DesktopContentHeader extends StatefulWidget {
  final Content featuredContent;

  const DesktopContentHeader({Key key, this.featuredContent}) : super(key: key);
  @override
  _DesktopContentHeaderState createState() => _DesktopContentHeaderState();
}

class _DesktopContentHeaderState extends State<DesktopContentHeader> {
  Content featuredContent;
  VideoPlayerController _controller;
  bool muted = true;

  @override
  void initState() {
    super.initState();
    featuredContent = widget.featuredContent;
    _controller = VideoPlayerController.network(widget.featuredContent.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0)
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.initialized
                ? _controller.value.aspectRatio
                : 2.3,
            child: _controller.value.initialized
                ? VideoPlayer(_controller)
                : Container(
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(featuredContent.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: AspectRatio(
              aspectRatio: _controller.value.initialized
                  ? _controller.value.aspectRatio
                  : 2.3,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(
                    featuredContent.titleImageUrl,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  featuredContent.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    PlayButton(),
                    SizedBox(width: 12),
                    FlatButton.icon(
                      padding: Responsive.isDesktop(context)
                          ? EdgeInsets.fromLTRB(25, 10, 30, 10)
                          : EdgeInsets.fromLTRB(15, 5, 20, 5),
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        size: 30,
                      ),
                      color: Colors.white,
                      label: Text(
                        'More Info',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_controller.value.initialized)
                      IconButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            muted
                                ? _controller.setVolume(100)
                                : _controller.setVolume(0);
                            muted = _controller.value.volume == 0;
                          });
                        },
                        iconSize: 30,
                        icon: Icon(
                          muted ? Icons.volume_off : Icons.volume_up,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.fromLTRB(25, 10, 30, 10)
          : EdgeInsets.fromLTRB(15, 5, 20, 5),
      icon: Icon(
        Icons.play_arrow,
        size: 30,
      ),
      color: Colors.white,
      label: Text(
        'Play',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onPressed: () {},
    );
  }
}
