import 'package:flutter/material.dart';
import 'widgets/yoga.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, // Remove the background color here
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9796f0), Color(0xfffbc7d4)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.7], // Adjust the stops as per your preference
            ),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16.0),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: [
              _buildWorkoutButton(
                context,
                'Weights',
                '/weight',
                'images/weight.png',
              ),
              _buildWorkoutButton(
                  context, 'Thighs', '/thigh', 'images/thigh.png'),
              _buildWorkoutButton(
                context,
                'Cardio',
                '/cardio',
                'images/cardio.png',
              ),
              _buildWorkoutButton(
                context,
                'Yoga',
                '/yoga',
                'images/yoga.png',
              ),
            ],
          ),
        ));
  }

  Widget _buildWorkoutButton(
    BuildContext context,
    String label,
    String route,
    String backgroundImage,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.white
                  .withOpacity(0.15), // Set the background color for the button
            ),
            Positioned.fill(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      builder: (context) => WorkoutRoutineScreen(
                        workoutType: label,
                        title: label,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  textStyle: const TextStyle(fontSize: 18.0),
                  elevation: 0,
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      backgroundColor: Colors.transparent,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutRoutineScreen extends StatelessWidget {
  final String workoutType;
  final String title;

  const WorkoutRoutineScreen(
      {Key? key, required this.workoutType, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildWorkoutContent(),
    );
  }

  Widget _buildWorkoutContent() {
    Widget content;
    switch (workoutType) {
      case 'Weights':
        content = _buildUpperBodyContent();
        break;
      case 'Thighs':
        content = _buildLowerBodyContent();
        break;
      case 'Cardio':
        content = _buildCardioContent();
        break;
      case 'Yoga':
        content = const BuildYogaContent();
        break;
      default:
        content = const Center(
          child: Text('Workout content not available.'),
        );
        break;
    }
    return content;
  }

  Widget _buildUpperBodyContent() {
    return const Center(
      child: Text('This is the Upper Body workout content.'),
    );
  }

  Widget _buildLowerBodyContent() {
    return const Center(
      child: Text('This is the Lower Body workout content.'),
    );
  }

  Widget _buildCardioContent() {
    return const Center(
      child: Text('This is the Cardio workout content.'),
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  CustomPageRoute({required this.builder});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}
