import 'package:flutter/material.dart';

import '../../app/dependencies.dart';
import '../../services/registration/registration_service.dart';
import '../viewmodel.dart';

String name;
String username;
String password;
String address;
String email;

class RegistrationViewModel extends Viewmodel {
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController addressController;
  TextEditingController emailController;
  GlobalKey<FormState> formKey;
  bool isSent;
  bool isChecked = false;
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

  RegistrationService get dataService => dependency();

  RegistrationViewModel();

  void init() async {
    nameController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isSent = false;
  }

  Future<bool> register() async {
    turnBusy();
    name = nameController.text;
    username = usernameController.text;
    password = passwordController.text;
    address = addressController.text;
    email = emailController.text;

    address = address + ", " + selectedState;
    print("address => " + address);
    int isRegistered =
        await dataService.register(name, username, password, email, address);
    turnIdle();
    selectedState = 'State';
    return isRegistered != -1 ? true : false;
  }

  // void setVariables() {
  //   turnBusy();
  //   name = nameController.text;
  //   username = usernameController.text;
  //   password = passwordController.text;
  //   address = addressController.text;
  //   email = emailController.text;
  //   turnIdle();
  // }

  // Future<String> checkUsername() async {
  //   if (verificationNoController.text != '123456')
  //     return 'The verification code is incorrect, please try again.';
  //   turnBusy();
  //   String availableStatus = await dataService.checkUsername(
  //       usernameController.text, emailController.text);
  //   turnIdle();
  //   return availableStatus;
  // }

  // void setIsSent() {
  //   turnBusy();
  //   isSent = true;
  //   turnIdle();
  // }

  // void setIsChecked() {
  //   turnBusy();
  //   isChecked = isChecked ? false : true;
  //   turnIdle();
  // }

  // Future<PickedFile> chooseImage() async {
  //   final _picker = ImagePicker();
  //   pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   return pickedFile;
  // }

  void dropdownStateOnChange(String newState) {
    selectedState = newState;
    print(selectedState);
    turnIdle();
  }
}
