import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/edit_profile/edit_profile_view.dart';
import 'package:yumyumfyp/widgets/profile_column.dart';

import '../../app/dependencies.dart';
import '../../widgets/custom_button.dart';
import '../view.dart';
import 'my_profile_viewmodel.dart';

class MyProfileScreen extends StatelessWidget {
  static const routeName = '/my_profile';
  static MaterialPageRoute createRoute() =>
      MaterialPageRoute(builder: (_) => MyProfileScreen());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<MyProfileViewModel>()..init(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Pacifico',
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        viewmodel.logOut();
                      },
                      child: Icon(Icons.logout),
                    )),
              ],
            ),
            // extendBodyBehindAppBar: true,
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 62,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            backgroundImage: viewmodel.user.profileImage != ""
                                ? NetworkImage(viewmodel.user.profileImage,
                                    scale: 40)
                                : AssetImage("assets/images/user.png"),
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -1,
                          child: Container(
                            width: 40,
                            child: RawMaterialButton(
                              onPressed: () async {
                                await viewmodel.chooseImage();
                              },
                              fillColor: Color.fromRGBO(255, 178, 102, 1),
                              child: Icon(
                                Icons.file_upload,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileColumn(
                    attributeName: "Name",
                    attribute: viewmodel.user.name,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 30,
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  ProfileColumn(
                    attributeName: "Username",
                    attribute: viewmodel.user.username,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 30,
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  ProfileColumn(
                    attributeName: "Email",
                    attribute: viewmodel.user.email,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 30,
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  ProfileColumn(
                    attributeName: "Address",
                    attribute: viewmodel.user.address,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: "Edit Profile",
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                  )
                ],
              ),
            )),
          );
        });
  }
}
