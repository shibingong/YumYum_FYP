import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/registration/registration_view.dart';

import '../../app/dependencies.dart';
import 'login_viewmodel.dart';
import '../view.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  static MaterialPageRoute createRoute() =>
      MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 229, 204, 1),
      body: ConsumerView(
        viewmodel: dependency<LoginViewModel>()..init(),
        builder: (context, viewmodel, _) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: SizedBox(
                      child: Text(
                        "YumYum",
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 200,
                child: Image.asset('assets/images/yumyum-icon.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Become cooking magician',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                  key: viewmodel.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 29, right: 29, bottom: 8),
                        child: CustomTextField(
                            hintText: 'Username',
                            obscured: false,
                            controller: viewmodel.usernameController),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 29, right: 29, bottom: 8),
                        child: CustomTextField(
                            hintText: 'Password',
                            obscured: true,
                            controller: viewmodel.passwordController),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 25),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                                text: 'Login',
                                onPressed: () async {
                                  if (!viewmodel.formKey.currentState
                                      .validate()) return;

                                  if (!await viewmodel.checkCredential())
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Invalid credential, please try again')));
                                }),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: new Text(
                              'New User? Sign Up Here',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.routeName);
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
