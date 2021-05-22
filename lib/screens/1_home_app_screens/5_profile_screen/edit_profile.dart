import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/helpers/loading_screen.dart';
import 'package:footsteps/main.dart';
import 'package:footsteps/screens/1_home_app_screens/5_profile_screen/widget/setting_text_field.dart';
import 'package:footsteps/screens/1_home_app_screens/app_bar.dart';
import 'package:footsteps/services/firebase_database.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/widgets/main_button.dart';
import 'package:images_picker/images_picker.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final DatabaseService databaseService = DatabaseService();
  File? imageAvatar;
  String? imageAvatarPath;
  DateTime? birthDayDate;
  String? photoURL;

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: auth.getUser()!.displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: ListView(
            padding: EdgeInsets.all(32),
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: (imageAvatar == null)
                      ? NetworkImage(auth.getUserImageUrl())
                      : FileImage(imageAvatar!) as ImageProvider,
                  child: Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () async {
                        _getImage();
                      },
                      color: AppColor.lightGreen,
                      iconSize: 48,
                    ),
                  ),
                  radius: 64,
                ),
              ),
              SizedBox(height: 32),
              SettingTextField(
                controller: nameController,
                label: "Name",
                keyboardType: TextInputType.name,
                //  icon: Icons.person,
                hint: "Your Name",
              ),
              SizedBox(height: 22),
              SettingTextField(
                controller: heightController,
                label: "Height",
                keyboardType: TextInputType.number,
                icon: Icons.straighten,
                hint: "Your Height",
                suffix: "CM",
              ),
              SizedBox(height: 22),
              SettingTextField(
                controller: weightController,
                label: "Weight",
                keyboardType: TextInputType.number,
                icon: Icons.monitor_weight_outlined,
                hint: "Your Weight",
                suffix: "KG",
              ),
              SizedBox(height: 22),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Birth Day",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(),
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: (birthDayDate == null)
                              ? BorderSide(width: 1, color: Color(0xffA0A0A0))
                              : BorderSide(
                                  width: 3, color: AppColor.lightGreen),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: AppColor.lightGreen,
                          ),
                          Text(
                            (birthDayDate == null)
                                ? "   Your Birth Date"
                                : "   ${birthDayDate.toString().substring(0, 10)}",
                            style: TextStyle(
                              color: (birthDayDate == null)
                                  ? AppColor.grey
                                  : AppColor.darkGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64),
              MainButton(
                  onPressed: () => databaseService.updateUserAccount(context,
                      name: nameController.text,
                      birthDayDate: birthDayDate!,
                      height: heightController.text,
                      weight: weightController.text,
                      image: imageAvatar,
                      onUpdateUser: () => _goToHomeApp()),
                  label: "Save")
            ],
          ),
        ),
        if (loading) LoadingScreen()
      ],
    );
  }

  Future _getImage() async {
    ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio(1, 1),
        cropType: CropType.rect,
      ),
      quality: 0.5,
      maxSize: 500,
    ).then((image) {
      setState(() {
        imageAvatar = File(image![0].path);
      });
    });
  }

  // void _uploadImageToFireStorage({required File image}) async {
  //   var fileName = path.basename(image.path);
  //   var snapshot = await storage.ref().child('images/$fileName').putFile(image);
  //   var downloadUrl = await snapshot.ref.getDownloadURL();

  //   user!.updateProfile(photoURL: downloadUrl);
  // }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: "selectBirthDate",
    );
    if (newDate != null) {
      setState(() {
        birthDayDate = newDate;
      });
    }
  }

  // void _updateUserAccount() {
  //   user!.updateProfile(displayName: nameController.text);

  //   users!
  //       .add({
  //         'uid': user!.uid,
  //         'birth_day': birthDayDate,
  //         'height': int.parse(heightController.text),
  //         'weight': int.parse(weightController.text)
  //       })
  //       .then((value) => _goToHomeApp())
  //       .catchError((error) => print("Failed to add user: $error"));
  //   print(user!.displayName);
  // }

  void _goToHomeApp() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomeAppBar.routeName, (route) => false);
  }
}
