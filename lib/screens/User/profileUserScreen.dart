import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static String id = 'ProfilePage';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          // User information

          // Edit profile button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implement edit profile page logic here
              },
              child: const Text('Edit Profile'),
            ),
          ),
          // Change password button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implement change password page logic here
              },
              child: const Text('Change Password'),
            ),
          ),
          // Addresses button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implement addresses page logic here
              },
              child: const Text('Addresses'),
            ),
          ),
          // Payment methods button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implement payment methods page logic here
              },
              child: const Text('Payment Methods'),
            ),
          ),
        ],
      ),
    );
  }
}
