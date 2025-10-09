// Deprecated wrapper: Use PersonalProfileScreen instead.
// تم استبدال هذه الشاشة بـ PersonalProfileScreen الأحدث.

import 'package:flutter/material.dart';
import 'personal_profile_screen.dart';

@Deprecated('استخدم PersonalProfileScreen')
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PersonalProfileScreen();
  }
}
