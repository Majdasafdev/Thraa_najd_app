import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snackbar/snackbar.dart';
import 'package:thraa_najd_mobile_app/main.dart';
import 'package:thraa_najd_mobile_app/models/UserModel.dart';
import 'package:thraa_najd_mobile_app/screens/User/EditProfileView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static String id = 'ProfileView';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('my-Profile'.tr()),
        actions: [
          IconButton(
              onPressed: () {
                if (userModel == null) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfileView(userModel: userModel!)));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: StreamBuilder<UserModel>(
          stream: repositoryClient.authRepository.getCurrentUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userModel = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name: ${userModel!.name}'.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('email ${userModel!.email}'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text('phone ${userModel!.phoneNumber ?? "--"}'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text('address ${userModel!.address ?? "--"}'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return Center(
              child: Text("loading".tr()),
            );
          }),
    );
  }
}
