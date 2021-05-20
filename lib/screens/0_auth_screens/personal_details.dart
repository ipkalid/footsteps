import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/auth_text_field.dart';
import 'package:footsteps/screens/1_home_app_screens/app_bar.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/widgets/main_button.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class PersonalDetailsScreen extends StatefulWidget {
  PersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  FirebaseFirestore? firestore;
  CollectionReference? users;
  FirebaseStorage storage = FirebaseStorage.instance;
  User? user;

  File? imageAvatar;
  String? imageAvatarPath;
  DateTime? birthDayDate;
  String? photoURL;

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    users = FirebaseFirestore.instance.collection('users');
    storage = FirebaseStorage.instance;
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: (imageAvatar == null)
                  ? null
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
          AuthTextField(
            controller: nameController,
            label: "Name",
            keyboardType: TextInputType.name,
            //  icon: Icons.person,
            hint: "Your Name",
          ),
          SizedBox(height: 22),
          AuthTextField(
            controller: heightController,
            label: "Height",
            keyboardType: TextInputType.number,
            icon: Icons.straighten,
            hint: "Your Height",
            suffix: "CM",
          ),
          SizedBox(height: 22),
          AuthTextField(
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
                      color: AppColor.darkGreen,
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
                          : BorderSide(width: 3, color: AppColor.lightGreen),
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
              onPressed: () => _updateUserAccount(),
              label: "Rigister Your Account")
        ],
      ),
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
        //print(image![0].toString());
        imageAvatar = File(image![0].path);
        //print(imageAvatar!.path);
        //print(imageAvatar);
        if (imageAvatar != null) {
          _uploadImageToFireStorage(image: imageAvatar!);
        }
      });
    });
  }

  void _uploadImageToFireStorage({required File image}) async {
    var fileName = path.basename(image.path);
    var snapshot = await storage.ref().child('images/$fileName').putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    user!.updateProfile(photoURL: downloadUrl);
  }

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

  void _updateUserAccount() {
    user!.updateProfile(displayName: nameController.text);

    users!
        .add({
          'uid': user!.uid,
          'birth_day': birthDayDate,
          'height': int.parse(heightController.text),
          'weight': int.parse(weightController.text)
        })
        .then((value) => _goToHomeApp())
        .catchError((error) => print("Failed to add user: $error"));
    print(user!.displayName);
  }

  void _goToHomeApp() {
    Navigator.pushReplacementNamed(context, HomeAppBar.routeName);
  }
}
