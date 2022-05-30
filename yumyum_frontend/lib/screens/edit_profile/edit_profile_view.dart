import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/my_profile/my_profile_viewmodel.dart';
import 'package:yumyumfyp/widgets/dropdownlist.dart';

import '../../app/dependencies.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../view.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/edit_profile';
  static MaterialPageRoute createRoute() =>
      MaterialPageRoute(builder: (_) => EditProfileScreen());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<MyProfileViewModel>()..editInit(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            // extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Form(
                    key: viewmodel.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'name',
                              obscured: false,
                              controller: viewmodel.nameController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'username',
                              obscured: false,
                              controller: viewmodel.usernameController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, bottom: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'password',
                              obscured: false,
                              controller: viewmodel.passwordController,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 29, right: 29, bottom: 5),
                                child: Container(
                                  height: 60,
                                  child: CustomTextField(
                                    hintText: 'city name',
                                    obscured: false,
                                    controller: viewmodel.addressController,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 29, bottom: 15),
                                  child: Container(
                                    height: 40,
                                    child: DropDownList(
                                        viewmodel.selectedState,
                                        viewmodel.dropdownStateOnChange,
                                        viewmodel.stateList),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, bottom: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'email',
                              controller: viewmodel.emailController,
                              inputType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        CustomButton(
                          text: 'Update',
                          onPressed: () {
                            viewmodel.updateProfile();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Update success!')));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
