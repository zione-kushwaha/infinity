import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i/core/firebase_storage/storage_service.dart';
import 'package:i/core/work/image_pick.dart';
import 'package:i/features/account/view/main_view.dart';
import 'package:path/path.dart' as p;
import '../repository/user_data_service.dart';

final formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String email;
  const UsernamePage({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  bool isValidate = true;
  bool isLoading = false;
  File? _imageFile;
  final String _defaultImage =
      'https://a0.anyrgb.com/pngimg/180/1072/user-profile-description-login-social-network-avatar-facebook-heroes-user-blog-point.png';

  void validateUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection("users").get();
    final users = usersMap.docs.map((user) => user).toList();
    String? targetedUsername;

    for (var user in users) {
      if (usernameController.text == user.data()["username"]) {
        targetedUsername = user.data()["username"];
        isValidate = false;
        setState(() {});
      }
      if (usernameController.text != targetedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter your username",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : NetworkImage(_defaultImage) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 110,
                    child: GestureDetector(
                      onTap: () async {
                        final image = await ImagePick().pickImage();
                        if (image != null) {
                          setState(() {
                            _imageFile = image;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: TextFormField(
                  onChanged: (username) {
                    validateUsername();
                    setState(() {}); // Trigger rebuild to update button color
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (username) {
                    if (username == null || username.isEmpty) {
                      return "Can't be empty";
                    } else if (username.length < 4) {
                      return "Can't be less than 4 characters";
                    }
                    return isValidate ? null : "Username already taken";
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    suffixIcon: isValidate
                        ? const Icon(Icons.verified_user_rounded)
                        : const Icon(Icons.cancel),
                    suffixIconColor: isValidate ? Colors.green : Colors.red,
                    hintText: "Insert username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isValidate && usernameController.text.length >= 4
                              ? Colors.green
                              : Colors.green.shade100,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: isLoading ||
                            !(isValidate && usernameController.text.length >= 4)
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              // Get the file type (extension)
                              final fileType = _imageFile != null
                                  ? p.extension(_imageFile!.path).substring(1)
                                  : null;

                              // Upload image to Firebase Storage
                              final imageUrl = _imageFile != null &&
                                      fileType != null
                                  ? await StorageService()
                                      .uploadUserPfps(_imageFile!, widget.email)
                                  : _defaultImage;

                              print('Image URL: $imageUrl');

                              // Add user data to Firestore
                              await ref
                                  .read(userDataServiceProvider)
                                  .addUserDataToFirestore(
                                      username: usernameController.text,
                                      email: widget.email,
                                      profilePic: imageUrl.toString());

                              // Navigate to MainView
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainView()));
                            } catch (e) {
                              print('Error: $e');
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            "CONTINUE",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
