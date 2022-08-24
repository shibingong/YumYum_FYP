import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yumyumfyp/app/auth.dart';
import 'package:yumyumfyp/models/user.dart';
import 'package:yumyumfyp/services/user/user_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

String name;
String username;
String password;
String address;
String email;

class MyProfileViewModel extends Viewmodel {
  User user;
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController addressController;
  TextEditingController emailController;
  GlobalKey<FormState> formKey;
  String selectedState = 'State';

  List<String> stateList = [
    'State',
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Perak',
    'Perlis',
    'Pulau Pinang',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'W.P. Kuala Lumpur',
    'W.P. Labuan',
    'W.P. Putrajaya',
  ];

  UserService get dataService => dependency();
  AuthService get authService => dependency();

  MyProfileViewModel();

  void init() async {
    turnBusy();
    user = await dataService.getUser();
    turnIdle();
  }

  void editInit() async {
    var tempAddress = user.address.split(", ");
    var address = tempAddress[0];
    selectedState = tempAddress[1];
    print(address);
    nameController = TextEditingController(text: user.name);
    usernameController = TextEditingController(text: user.username);
    passwordController = TextEditingController(text: user.password);
    addressController = TextEditingController(text: address);
    emailController = TextEditingController(text: user.email);
    formKey = GlobalKey<FormState>();
  }

  Future updateProfile(context) async {
    user.name = nameController.text;
    user.username = usernameController.text;
    user.password = passwordController.text;
    user.address = addressController.text;
    user.email = emailController.text;

    user.address = user.address + ", " + selectedState;
    turnBusy();
    await dataService.updateUser(user);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Update success!')));
    Navigator.of(context).pop();
    init();
    turnIdle();
  }

  void dropdownStateOnChange(String newState) {
    selectedState = newState;
    print(selectedState);
    turnIdle();
  }

  Future<void> chooseImage() async {
    final _picker = ImagePicker();
    XFile pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("here");
      File file = File(pickedFile.path);
      String photourl = await dataService.uploadImage(file);
      user.profileImage = photourl;
      turnIdle();
    }
  }

  void logOut() {
    authService.triggerLogOut();
  }
}
