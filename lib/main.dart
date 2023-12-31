import 'package:flutter/material.dart';
import 'workout_screen.dart';
import 'about_widget.dart';
import 'question_widget.dart';
import 'book_search_screen.dart';
import 'package:flutter/services.dart';

void main() {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Workout Routine';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trying Flutter',
      theme: ThemeData(
        primaryColor: Colors.pink[500],
      ),
      routes: {
        '/upper_body': (context) => const WorkoutRoutineScreen(
              workoutType: 'Upper Body',
              title: 'Upper Body Workout',
            ),
        '/lower_body': (context) => const WorkoutRoutineScreen(
              workoutType: 'Lower Body',
              title: 'Lower Body Workout',
            ),
        '/cardio': (context) => const WorkoutRoutineScreen(
              workoutType: 'Cardio',
              title: 'Cardio Workout',
            ),
        '/yoga': (context) => const WorkoutRoutineScreen(
              workoutType: 'Yoga',
              title: 'Yoga Workout',
            ),
        '/book_search': (context) => const BookSearchScreen(),
      },
      home: const MyHomePage(title: appTitle),
    );
  }
}

final List<Widget Function(String)> _widgetOptions = <Widget Function(String)>[
  (title) => const WorkoutScreen(),
  (title) => aboutWidget(),
  (title) => questionWidget(),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  void navigateToScreen(BuildContext context, String title, int index) {
    Navigator.push(
      context,
      CustomPageRoute(
        builder: (context) => _widgetOptions[index](title),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      String title;
      switch (index) {
        case 0:
          title = 'Workout List';
          Navigator.pop(context);
        case 1:
          title = 'About';
          Navigator.pop(context);
        case 2:
          title = 'Questions';
          Navigator.pop(context);

        default:
          title = 'Workout Routine'; // Default title if needed
      }
      widget.navigateToScreen(
          context, title, index); // Use widget.navigateToScreen here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Routine'),
        backgroundColor: Colors.transparent, // Remove the background color here
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0052D4), Color(0xff4364F7), Color(0xff6FB1FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1], // Adjust the stops as per your preference
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex](widget.title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset('images/grow.png', fit: BoxFit.contain),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: const Text('About'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
              },
            ),
            ListTile(
              title: const Text('Questions'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
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
