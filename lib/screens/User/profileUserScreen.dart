import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Edit Profile'),
          actions: [
            TextButton(
              onPressed: () {
                // Handle "Done" button press
              },
              child: const Text('Done'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Eduardo Amaral',
                ),
              ),
              const SizedBox(height: 16),
              const Text('E-mail',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'edu@gmail.com',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('+966'),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '59-700-5649',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Adress',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'City - district - street',
                ),
              ),
              const SizedBox(height: 36),
              const Text('Orders',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'My orders',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
