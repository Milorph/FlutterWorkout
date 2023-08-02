import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildExerciseSection extends StatelessWidget {
  const BuildExerciseSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yoga Exercise',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Practice these basic yoga exercises to start your yoga journey. Each pose should be held for a few breaths or as long as comfortable. '
            'Focus on proper alignment and breathing throughout each posture.\n\n'
            'Remember to warm up before starting the exercises and cool down afterward. '
            'Listen to your body and modify the poses as needed to suit your individual flexibility and fitness level.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildExerciseItem(
            context,
            'Mountain Pose (Tadasana)',
            'Stand with feet together, hands at your sides, and distribute your weight evenly on both feet. Lengthen your spine, relax your shoulders, and engage your core.',
            FontAwesomeIcons.mountain,
            'https://www.youtube.com/watch?v=NYhH8Gr35cI&ab_channel=YogaWithAdriene'),
        _buildExerciseItem(
          context,
          'Child\'s Pose (Balasana)',
          'Start on your hands and knees. Sit back on your heels, reaching your arms forward and lowering your chest towards the mat. This is a resting pose to release tension in the back and neck.',
          FontAwesomeIcons.child,
          'https://www.youtube.com/watch?v=eqVMAPM00DM&list=RDQME3OlRI1Cg64&start_radio=1&ab_channel=YogaWithAdriene',
        ),
        _buildExerciseItem(
          context,
          'Warrior II (Virabhadrasana II)',
          'Step your feet wide apart, extend your arms parallel to the ground, and bend your front knee. Keep your back leg straight and your chest open.',
          FontAwesomeIcons.personRunning,
          'https://www.youtube.com/watch?v=4Ejz7IgODlU&ab_channel=YogaWithAdriene',
        ),
        _buildExerciseItem(
          context,
          'Tree Pose (Vrksasana)',
          'Stand on one leg, placing the sole of the opposite foot on the inner thigh or calf. Bring your hands to your heart center or extend them overhead. '
              'Focus on balance and stability in this pose.',
          FontAwesomeIcons.tree,
          'https://www.youtube.com/watch?v=yVE4XXFFO70&ab_channel=YogaWithAdriene',
        ),
      ],
    );
  }

  Widget _buildExerciseItem(
    BuildContext context,
    String title,
    String description,
    IconData iconData,
    String url,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          iconData,
          size: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            FontAwesomeIcons.play,
            size: 24,
            color: Colors.green,
          ),
          onPressed: () {
            _launchURL(url);
          },
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  final Uri urli = Uri.parse(url);
  if (await canLaunchUrl(urli)) {
    await launchUrl(urli);
  } else {
    throw Exception('Could not launch $urli');
  }
}
