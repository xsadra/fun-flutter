import 'package:flutter/material.dart';

import '../constants.dart';

class Course {
  final String title, description, iconSrc;
  final Color bgColor;

  Course({
    required this.title,
    this.description = "Build and animate an iOS app from scratch",
    this.iconSrc = Assets.ios ,
    this.bgColor = const Color(0xFF7553F6),
  });
}

List<Course> courses = [
  Course(title: "Animations in SwiftUI"),
  Course(
    title: "Animations in Flutter",
    iconSrc:  Assets.code,
    bgColor: const Color(0xFF80A4FF),
  ),
];

// We need it later
List<Course> recentCourses = [
  Course(title: "State Machine"),
  Course(
    title: "Animated Menu",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc:  Assets.code,
  ),
  Course(title: "Flutter with Rive"),
  Course(
    title: "Animated Menu",
    bgColor: const Color(0xFF9CC5FF),
    iconSrc:  Assets.code,
  ),
];