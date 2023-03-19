import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:land_conversion_kodagu/View/application_form.dart';

import 'package:land_conversion_kodagu/database/application_stepper.dart';
import 'package:land_conversion_kodagu/providers/application_provider.dart';
import 'package:land_conversion_kodagu/testing/temp/custom_dropdown.dart';
import 'package:land_conversion_kodagu/testing/uploadjs.dart';
import 'package:provider/provider.dart';

import '../testing/temp/upl_node.dart';

import '../utilities/controller/simple_ui_controller.dart';

import '../utilities/constants.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<String> department = [
    'Revinue Inspector',
    'Mining Department',
    'Tashildar',
    'Deputy Comissioner',
    'Additional Deputy Comissioner'
  ];
  String? selectedDept;

  bool isVisible = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              // decoration: BoxDecoration(
              //     color: Colors.amber,
              //     borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(16),
              //         bottomRight: Radius.circular(16))),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const AutoSizeText(
                    'Government Of Karnataka',
                    style: headingTextStyle,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.anglesDown),
                        onPressed: () {
                          print("Pressed");
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          // ignore: prefer_const_constructors
          child: Container(
            margin: EdgeInsets.only(
                left: size.width * 0.18,
                right: size.width * 0.18,
                bottom: 100,
                top: size.height * 0.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 16, 11, 56),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Column(
              children: [
                // Divider(
                //   color: Colors.black54,
                //   thickness: 1,
                // ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Opacity(
                          opacity: 0.9,
                          child: Container(
                            // margin:
                            //     EdgeInsets.only(bottom: 60, top: 60, left: 60),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/conversion.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  topLeft: Radius.circular(16)),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.black12),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(175, 224, 224, 224),
                                  borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: size.height * 0.2),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // RotatedBox(
                                    //   quarterTurns: 0,
                                    //   child: Lottie.asset(
                                    //     'assets/application.json',
                                    //     height: size.height * 0.6,
                                    //     width: double.infinity - 1,
                                    //     fit: BoxFit.contain,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        'Wanted to apply for\nLand conversion ?',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 2, 2, 47),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          overflow: TextOverflow.fade,
                                          shadows: [
                                            Shadow(
                                              color: Color.fromARGB(
                                                  210, 255, 255, 255),
                                              blurRadius: 9.0,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    _applyButton(size),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child:
                              _buildMainBody(size, simpleUIController, theme)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  Widget _applyButton(Size size) {
    return SizedBox(
      width: 240,
      child: TextButton(
          child: Text(
            'Click to apply..',
            style: TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 255, 255, 255),
                  blurRadius: 3.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(16.0)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 34, 25, 195)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 14, 35, 219))))),
          onPressed: () {
            ApplicationProvider provider =
                Provider.of<ApplicationProvider>(context, listen: false);
            log('=>Login ${provider.selectedMain}');
// Send a GET request to the Node.js server
            // Dio()
            //     .get('http://localhost:3000/path/to/endpoint')
            //     .then((response) {
            //   // Handle the response from the server
            //   print(response.data);
            // }).catchError((error) {
            //   // Handle any errors that occur
            //   print(error);
            // });

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadToNode(),
                ));
          }),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Container(
      //   margin: EdgeInsets.only(bottom: 60, top: 60, right: 60),
      padding: const EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
        border: Border.all(style: BorderStyle.solid, color: Colors.black12),
      ),
      child: ListView(
        children: [
          Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: size.width > 600
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              // size.width > 600
              //     ? Container()
              //     : Lottie.asset(
              //         'assets/wave.json',
              //         height: size.height * 0.2,
              //         width: size.width,
              //         fit: BoxFit.fill,
              //       ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Sign In ',
                  style: kLoginTitleStyle(size),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      elevation: 8,
                      hint: const Padding(
                        padding: leftRightPadding,
                        child: Text('Select Your Department'),
                      ),
                      // taluk_names.map(buildMenuItem).toList()

                      items: department
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      // hobli_.map(buildMenuItemHobli).toList(),
                      validator: (_selectedHobli) {
                        _selectedHobli == null
                            ? 'Please fill the details.'
                            : null;
                      },
                      onChanged: (String? value_) => dropDownState(() {
                        this.selectedDept = value_;
                        setState(() {
                          if (value_ == 'Tashildar') {
                            isVisible = true;
                          } else {
                            isVisible = false;
                          }
                        });

                        // if (value_ == '1') {
                        //   setState(() {
                        //     sub = true;
                        //     sub_intension = housing;
                        //     print(sub_intension);
                        //   });
                        // }
                        // if (value_ == '2') {
                        //   setState(() {
                        //     sub = true;
                        //     sub_intension = commercial;
                        //   });
                        // }
                      }),
                      value: selectedDept,
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// username
                      TextFormField(
                        style: kTextFormFieldStyle(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),

                        controller: nameController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (value.length < 4) {
                            return 'at least enter 4 characters';
                          } else if (value.length > 13) {
                            return 'maximum character is 13';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      // /// Gmail
                      // TextFormField(
                      //   style: kTextFormFieldStyle(),
                      //   controller: emailController,
                      //   decoration: const InputDecoration(
                      //     prefixIcon: Icon(Icons.email_rounded),
                      //     hintText: 'gmail',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(15)),
                      //     ),
                      //   ),
                      //   // The validator receives the text that the user has entered.
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter gmail';
                      //     } else if (!value.endsWith('@gmail.com')) {
                      //       return 'please enter valid gmail';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),

                      /// password
                      Obx(
                        () => TextFormField(
                          style: kTextFormFieldStyle(),
                          controller: passwordController,
                          obscureText: simpleUIController.isObscure.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: IconButton(
                              icon: Icon(
                                simpleUIController.isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                simpleUIController.isObscureActive();
                              },
                            ),
                            hintText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value.length < 7) {
                              return 'at least enter 6 characters';
                            } else if (value.length > 13) {
                              return 'maximum character is 13';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      size.height >= 850
                          ? Wrap(children: [
                              const Icon(
                                Icons.warning,
                              ),
                              Text(
                                'This is for Authorized Officers only',
                                style: kLoginTermsAndPrivacyStyle(size),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ])
                          : Container(),
                      SizedBox(
                        height: 16,
                      ),

                      /// SignUp Button
                      ///

                      signUpButton(theme, size),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      // /// Navigate To Login Screen
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         CupertinoPageRoute(
                      //             builder: (ctx) => const LoginView()));
                      //     nameController.clear();
                      //     emailController.clear();
                      //     passwordController.clear();
                      //     _formKey.currentState?.reset();

                      //     simpleUIController.isObscure.value = true;
                      //   },
                      //   child: RichText(
                      //     text: TextSpan(
                      //       text: 'Already have an account?',
                      //       style: kHaveAnAccountStyle(size),
                      //       children: [
                      //         TextSpan(
                      //             text: " Login",
                      //             style: kLoginOrSignUpTextStyle(size)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme, Size size) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      constraints: BoxConstraints(maxWidth: size.width * 0.4, minHeight: 50.0),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ElevatedButton(
        onPressed: () async {
          // log(controller1.text);
          //     if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Succesfully"),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ProfileScreen(),
            //     ));

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StepperDemo(),
                  //FileUploadForm(),
                ));
          });
          //Navigator.of(context).pop();
          // } else {
          //   log("Error Adding");
          //   return;
          // }
        },
        //},
        //  color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Sign In',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.login,
                  color: successColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
