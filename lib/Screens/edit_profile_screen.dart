import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/user_model.dart';
import 'package:flutter_application_1/Cubits/edit%20profile%20cubit/edit_profile_data.cubit.dart';
import 'package:flutter_application_1/Cubits/edit%20profile%20cubit/edit_profile_data_kiroo.dart';
import 'package:flutter_application_1/Cubits/edit%20profile%20cubit/edit_profile_data_state.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/widgets/build_editable_text_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
                  BlocConsumer<EditProfileDataCubit, EditProfileDataState>(
                      listener: (context, state) {
                    if (state is ProfileImageUploadSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("profile picture uploaded succeffully")));
                    } else if (state is ProfileImageError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)));
                    }
                    if (state is ProfileImageDeleteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Profile picture deleted")),
                      );
                      // You might want to reload user data here.
                    } else if (state is ProfileImageError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  }, builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Center(
                              child: FutureBuilder(
                                  future: AppPrefs.getProfileImageTimestamp(),
                                  builder: (context, snapshot) {
                                    String imageUrl = user!.imageUrl!;
                                    if (snapshot.hasData) {
                                      imageUrl += "?v=${snapshot.data}";
                                    }

                                    return Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundImage: user?.imageUrl !=
                                                  null
                                              ? NetworkImage(imageUrl)
                                              : AssetImage('assets/person.png'),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () async {},
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade400,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 3,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery)
                                                            .then(
                                                              // ignore: use_build_context_synchronously
                                                              (value) => context
                                                                  .read<
                                                                      EditProfileDataCubit>()
                                                                  .uploadProfileImage(
                                                                      file:
                                                                          value!),
                                                            );
                                                      },
                                                      child: const Icon(
                                                        Icons.camera_alt_sharp,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(Icons.delete),
                                          label: Text("Delete"),
                                          onPressed: () async {
                                            final confirm = await showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: Text("Confirm"),
                                                content: Text(
                                                    "Are you sure you want to delete your profile picture?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, false),
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, true),
                                                    child: Text("Delete"),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (confirm == true) {
                                              context
                                                  .read<EditProfileDataCubit>()
                                                  .deleteProfileImage();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  })),
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
                                      content:
                                          Text("Failed to update profile")),
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
                    );
                  }),
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
