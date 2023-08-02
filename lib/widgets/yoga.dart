import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'yoga_widgets/about_section_yoga.dart';
import 'yoga_widgets/calories_section_yoga.dart';
import 'yoga_widgets/exercise_section_yoga.dart';

class BuildYogaContent extends StatefulWidget {
  const BuildYogaContent({Key? key}) : super(key: key);

  @override
  BuildYogaContentState createState() => BuildYogaContentState();
}

class BuildYogaContentState extends State<BuildYogaContent>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _showResumeButton = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {
        if (_controller.value.isPlaying) {
          _showResumeButton = false;
        } else if (_controller.value.isInitialized &&
            !_controller.value.isPlaying) {
          _showResumeButton = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff9796f0), Color(0xfffbc7d4)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.7],
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                  Visibility(
                    visible: _showResumeButton,
                    child: const Icon(
                      Icons.play_arrow,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    indicator: const CircleTabIndicator(
                        color: Colors.black, radius: 4),
                    tabs: const [
                      Tab(
                        child: Text(
                          "About",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Exercise",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Calories",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: const [
                            BuildAboutSection(),
                            SizedBox(height: 20),
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: const [
                            BuildExerciseSection(),
                            SizedBox(height: 20),
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: const [
                            BuildCaloriesSection(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
