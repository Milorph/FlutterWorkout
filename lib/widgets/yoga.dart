import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
            stops: [0.1, 0.7], // Adjust the stops as per your preference
          ),
        ),
        child: Column(children: [
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
                  indicator:
                      const CircleTabIndicator(color: Colors.black, radius: 4),
                  tabs: const [
                    Tab(
                      child: Text(
                        "About",
                        style: TextStyle(
                            fontSize: 16), // Increase the font size here
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Exercise",
                        style: TextStyle(
                            fontSize: 16), // Increase the font size here
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Calories",
                        style: TextStyle(
                            fontSize: 16), // Increase the font size here
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
                          children: [
                            _buildAboutSection(),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: [
                            _buildExerciseSection(),
                          ]),
                      ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20.0),
                          children: [
                            _buildCaloriesSection(),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget yogaSection = const TabBarView(children: []);

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

Widget _buildAboutSection() {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Text(
          'About Yoga',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Yoga is a wonderful practice that helps in harmonizing the mind, body, and spirit. It has been practiced for centuries to promote physical, mental, and emotional well-being. This yoga workout routine is designed to help you improve flexibility, strength, and balance while bringing a sense of peace and relaxation to your daily life.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

Widget _buildExerciseSection() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        const Text(
          'Yoga Exercise',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Practice these basic yoga exercises to start your yoga journey:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        _buildExerciseItem(
          'Mountain Pose (Tadasana)',
          'Stand with feet together, hands at your sides, and distribute your weight evenly on both feet. Lengthen your spine, relax your shoulders, and engage your core.',
        ),
        _buildExerciseItem(
          'Child\'s Pose (Balasana)',
          'Start on your hands and knees. Sit back on your heels, reaching your arms forward and lowering your chest towards the mat. This is a resting pose to release tension in the back and neck.',
        ),
        // Add more exercises as needed
      ],
    ),
  );
}

Widget _buildCaloriesSection() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        const Text(
          'Yoga for Burning Calories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'While yoga is not typically a high-calorie burning exercise like cardio, it can still help with weight management and overall fitness. Here are some yoga poses that may help increase calorie burn:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        _buildCaloriesItem(
          'Sun Salutation (Surya Namaskar)',
          'A flowing sequence of poses that can help improve flexibility, strength, and heart rate.',
        ),
        _buildCaloriesItem(
          'Plank Pose (Phalakasana)',
          'A core-strengthening pose that engages multiple muscle groups and helps improve posture.',
        ),
        // Add more poses as needed
      ],
    ),
  );
}

Widget _buildExerciseItem(String title, String description) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      description,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}

Widget _buildCaloriesItem(String title, String description) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      description,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
