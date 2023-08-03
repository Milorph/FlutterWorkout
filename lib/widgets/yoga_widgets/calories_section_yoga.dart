import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildCaloriesSection extends StatelessWidget {
  const BuildCaloriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Yoga for Burning Calories',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'While yoga is not typically a high-calorie burning exercise like cardio, '
            'it can still help with weight management and overall fitness. '
            'The number of calories burned during a yoga session depends on various factors, including intensity, duration, and individual body weight.\n\n'
            'On average, a 150-pound person can expect to burn approximately 150-250 calories in a one-hour yoga session. '
            'This calorie burn can vary based on the type of yoga practiced and the pace of the session.\n\n'
            "Keep in mind that yoga's benefits extend beyond calorie burning. It promotes mindfulness, stress reduction, and physical well-being, "
            'making it an excellent addition to any fitness routine.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildCaloriesItem(
          'Sun Salutation (Surya Namaskar)',
          'A flowing sequence of poses that can help improve flexibility, strength, and heart rate. '
              'One round of Sun Salutation can burn approximately 13-20 calories, depending on the pace.',
          FontAwesomeIcons.sun,
          'https://www.youtube.com/watch?v=8AakYeM23sI&ab_channel=YogaWithAdriene',
        ),
        _buildCaloriesItem(
          'Plank Pose (Phalakasana)',
          'A core-strengthening pose that engages multiple muscle groups and helps improve posture. '
              'Holding Plank Pose for one minute can burn around 2-3 calories.',
          FontAwesomeIcons.list,
          'https://www.youtube.com/watch?v=6qg3r4zZE_k&ab_channel=YogaWithAdriene',
        ),
        _buildCaloriesItem(
          'Bridge Pose (Setu Bandhasana)',
          'Lie on your back, bend your knees, and lift your hips off the ground. '
              'This pose can help tone the glutes and lower back. Holding Bridge Pose for one minute can burn approximately 3-4 calories.',
          FontAwesomeIcons.rightLeft,
          'https://www.youtube.com/watch?v=NnbvPeAIhmA&ab_channel=YogaWithAdriene',
        ),
      ],
    );
  }
}

Widget _buildCaloriesItem(
    String title, String description, IconData iconData, String url) {
  return Card(
    child: ListTile(
      leading: Icon(
        iconData,
        size: 40,
        color: Colors.green,
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

void _launchURL(String url) async {
  final Uri urli = Uri.parse(url);
  if (await canLaunchUrl(urli)) {
    await launchUrl(urli);
  } else {
    throw Exception('Could not launch $urli');
  }
}
