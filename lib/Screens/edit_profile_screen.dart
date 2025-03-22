import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/build_editable_text_field.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String bio;

  EditProfileScreen({
    required this.name,
    required this.email,
    required this.bio,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    bioController = TextEditingController(text: widget.bio);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showappbar: true,
      screenName: "Edit Profile",
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/person.png'),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit,
                      color: Color(0xffFED36A)),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            buildEditableTextField('Name', nameController, false, isEditing),
            buildEditableTextField(
                'E-mail Address', emailController, false, isEditing),
            buildEditableTextField('Bio', bioController, false, isEditing),
          ],
        ),
      ),
    );
  }
}
