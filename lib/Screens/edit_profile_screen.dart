import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/edit%20profile%20cubit/edit_profile_data_cubit.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/build_editable_text_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

import 'package:flutter_application_1/widgets/pick_image_widget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isEditing = false;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final loadedUser = await AppPrefs.getUser();
    if (loadedUser != null) {
      setState(() {
        user = loadedUser;
        nameController = TextEditingController(text: user!.userName);
        emailController = TextEditingController(text: user!.email);
        phoneNumberController =
            TextEditingController(text: user!.phoneNumber ?? '');
        bioController = TextEditingController(text: user!.bio);
      });
    }
  }

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      showappbar: true,
      screenName: "Edit Profile",
      child: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(child: const PickImageWidget()),
                      ),
                      IconButton(
                        icon: Icon(
                          isEditing ? Icons.check : Icons.edit,
                          color: Color(0xffFED36A),
                        ),
                        onPressed: () async {
                          if (isEditing) {
                            // Save changes to server
                            final updatedUser = UserModel(
                              id: user!.id, // make sure to include the ID
                              userName: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneNumberController.text,
                              bio: bioController.text,
                              imageUrl: user!.imageUrl,
                              fullName: user!.fullName,
                            );

                            final success =
                                await updateUserOnServer(updatedUser);
                            if (success) {
                              // Optionally update local storage
                              await AppPrefs.getUser();

                              setState(() {
                                user = updatedUser;
                                isEditing = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Profile updated successfully")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Failed to update profile")),
                              );
                            }
                          } else {
                            setState(() {
                              isEditing = true;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildEditableTextField(
                      'Username', nameController, false, isEditing),
                  buildEditableTextField(
                      'E-mail Address', emailController, false, isEditing),
                  buildEditableTextField(
                      'Phone Number', phoneNumberController, false, isEditing),
                  buildEditableTextField(
                      'Bio', bioController, false, isEditing),
                ],
              ),
            ),
    );
  }
}
