import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/screens/User/cartScreen.dart';
import 'package:thraa_najd_mobile_app/constants.dart';

class User {
  final String kNameOfClient;
  final String email;
  final String kMobileNumClinet;
  final String imageUrl;

  User(
      {required this.kNameOfClient,
      required this.email,
      required this.imageUrl,
      required this.kMobileNumClinet});
}

class ProfilePage extends StatelessWidget {
  late User user;

  static String id = 'ProfilePage';

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          // User information
          UserInfo(
            user: user,
          ),
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

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
          const SizedBox(height: 16),
          Text(
            user.kNameOfClient,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
