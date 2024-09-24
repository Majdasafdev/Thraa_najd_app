import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/UserModel.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';

import '../../widgets/snack_bar.dart';

class EditProfileView extends StatefulWidget {
  final UserModel userModel;

  const EditProfileView({super.key, required this.userModel});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userModel.name;
    phoneNumberController.text = widget.userModel.phoneNumber ?? "";
    addressController.text = widget.userModel.address ?? "";
    emailController.text = widget.userModel.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "name".tr()),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(hintText: "address".tr()),
              ),
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
                  Expanded(
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: '59-700-5649',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      if (didChange()) {
                        var result = await repositoryClient.authRepository
                            .editUserInfo(widget.userModel.copyWith(
                                address: addressController.value.text.trim(),
                                name: nameController.value.text.trim(),
                                phoneNumber:
                                    phoneNumberController.value.text.trim()));
                        if (result == true && context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                      if (emailController.value.text.trim() !=
                          widget.userModel.email) {
                        await repositoryClient.authRepository
                            .updateEmail(emailController.value.text.trim());
                      }
                    } catch (e, stk) {
                      if (context.mounted) {
                        showSnackBar(context, e.toString());
                      }
                    }
                  },
                  child: const Text("confirm"))
            ],
          ),
        ),
      ),
    );
  }

  bool didChange() {
    return addressController.value.text.trim() != widget.userModel.address ||
        nameController.value.text.trim() != widget.userModel.name ||
        phoneNumberController.value.text.trim() != widget.userModel.phoneNumber;
  }
}
