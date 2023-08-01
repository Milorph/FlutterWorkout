import 'package:flutter/material.dart';
import 'widgets/title_section.dart';
import 'widgets/button_section.dart';
import 'widgets/text_section.dart';

Widget aboutWidget() {
  return ListView(
    children: [
      Image.asset(
        'images/lake.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
      titleSection,
      buttonSection,
      textSection,
    ],
  );
}
