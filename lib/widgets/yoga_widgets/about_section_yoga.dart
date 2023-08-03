import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildAboutSection extends StatelessWidget {
  const BuildAboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'About Yoga',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Yoga is a wonderful practice that helps in harmonizing the mind, body, and spirit. '
            'It has been practiced for centuries to promote physical, mental, and emotional well-being. '
            'This yoga workout routine is designed to help you improve flexibility, strength, and balance while bringing a sense of peace and relaxation to your daily life.\n\n'
            'Yoga involves a combination of physical postures (asanas), breathing exercises (pranayama), '
            'and meditation techniques that contribute to overall health and wellness. '
            'Through consistent practice, yoga can reduce stress, improve mental clarity, and boost immune function.\n\n'
            "Additionally, yoga's focus on deep breathing and relaxation can help lower blood pressure and reduce the risk of heart disease. "
            'The mindfulness aspect of yoga encourages self-awareness and positive thinking, leading to a more balanced and fulfilling life.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Health Benefits of Yoga:',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        _buildBulletPoint('Stress Reduction'),
        _buildBulletPoint('Improved Flexibility'),
        _buildBulletPoint('Enhanced Balance and Coordination'),
        _buildBulletPoint('Muscle Strengthening'),
        _buildBulletPoint('Increased Mindfulness and Inner Peace'),
        _buildBulletPoint('Improved Respiratory Function'),
        _buildBulletPoint('Enhanced Posture and Alignment'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.brightness_1,
          size: 8,
          color: Colors.black87,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
