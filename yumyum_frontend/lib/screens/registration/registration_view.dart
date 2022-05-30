import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/login/login_view.dart';
import 'package:yumyumfyp/widgets/dropdownlist.dart';

import '../../app/dependencies.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../view.dart';
import 'registration_viewmodel.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/registration';
  static MaterialPageRoute createRoute(args) =>
      MaterialPageRoute(builder: (_) => RegistrationScreen());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RegistrationViewModel>()..init(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Registration",
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
                        // Container(
                        //   height: 100,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 40, right: 40),
                        //   child: Container(
                        //     height: 150,
                        //     child: Image.asset(
                        //       'assets/img/logo-01.png',
                        //     ),
                        //   ),
                        // ),
                        // Text(
                        //   'Registration',
                        //   style: TextStyle(fontSize: 30),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'Name',
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
                              hintText: 'Username',
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
                              hintText: 'Password',
                              obscured: true,
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
                                    hintText: 'City Name',
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
                              hintText: 'Email',
                              controller: viewmodel.emailController,
                              inputType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        CustomButton(
                            text: 'Register',
                            onPressed: () async {
                              await viewmodel.register().then((value) => value
                                  ? {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Registered Successsfully!'))),
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst)
                                    }
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'We have encountered some problem. Please try again'))));
                            }),
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
