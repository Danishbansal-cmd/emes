import 'dart:convert';

import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(milliseconds: 500), () {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (context) {
    //       Future.delayed(
    //         Duration(milliseconds: 300),
    //         () {
    //           Navigator.of(context).pop(true);
    //         },
    //       );
    //       return Dialog(
    //         elevation: 0,
    //         backgroundColor: Colors.transparent,
    //         child: Stack(
    //           children: [
    //             Center(
    //               child: Container(
    //                 width: 60,
    //                 height: 60,
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 10, vertical: 10),
    //                 child: const CircularProgressIndicator(),
    //                 decoration: const BoxDecoration(color: Colors.white),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // });
  }

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = Constants.getFirstName;
    lastNameController.text = Constants.getLastName;
    emailController.text = Constants.getEmail;
    mobileController.text = Constants.getMobile;
    final _textTheme = Theme.of(context).textTheme;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return true;
      },
      child: SingleChildScrollView(
        child: ChangeNotifierProvider<ProfilePageFormProvider>(
          create: (_) => ProfilePageFormProvider(),
          child: Container(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //First Name row
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return returnFormRow(
                        "First Name",
                        firstNameController,
                        profilePageFormProvider.setFirstNameError,
                        profilePageFormProvider.getFirstNameError,
                        context);
                  },
                ),
                //
                //Last Name row
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return returnFormRow(
                        "Last Name",
                        lastNameController,
                        profilePageFormProvider.setLastNameError,
                        profilePageFormProvider.getLastNameError,
                        context);
                  },
                ),
                //
                //Mobile row
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return returnFormRow(
                        "Mobile",
                        mobileController,
                        profilePageFormProvider.setMobileError,
                        profilePageFormProvider.getMobileError,
                        context);
                  },
                ),
                //
                //Email row
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return returnFormRow(
                        "Email",
                        emailController,
                        profilePageFormProvider.setEmailError,
                        profilePageFormProvider.getEmailError,
                        context);
                  },
                ),
                //
                //Update Button
                const SizedBox(
                  height: 15,
                ),
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        // splashColor: Colors.white,
                        onTap: () {
                          profilePageFormProvider
                              .setFirstNameError(firstNameController.text);
                          profilePageFormProvider
                              .setLastNameError(lastNameController.text);
                          profilePageFormProvider
                              .setMobileError(mobileController.text);
                          profilePageFormProvider
                              .setEmailError(emailController.text);

                          if (firstNameController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty &&
                              profilePageFormProvider.getMobileErrorBool ==
                                  false &&
                              profilePageFormProvider.getEmailErrorBool ==
                                  false) {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        // .copyWith(top: 0),
                                        height: 100,
                                        width: double.infinity,
                                        child: FutureBuilder(
                                          future: ProfilePageFormProvider
                                              .updateProfile(
                                            firstNameController.text,
                                            lastNameController.text,
                                            mobileController.text,
                                            emailController.text,
                                          ),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                Future.delayed(
                                                    Duration(
                                                      milliseconds: 500,
                                                    ), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return SingleChildScrollView(
                                                  child: Text(
                                                    '${snapshot.error} occured',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                // Future.delayed(
                                                //     Duration(
                                                //       milliseconds: 500,
                                                //     ), () {
                                                //   Navigator.of(context)
                                                //       .pop(true);
                                                // });
                                                
                                                final data =
                                                    snapshot.data as Map;
                                                if (data['status'] == 200) {
                                                  Constants.setFirstName(firstNameController.text);
                                                  Constants.setLastName(lastNameController.text);
                                                  Constants.setMobile(mobileController.text);
                                                  Constants.setEmail(emailController.text);
                                                }
                                                print(Constants.getMobile);
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Text(data['status']
                                                          .toString()),
                                                      Text(data['data']
                                                          ['mobile']),
                                                      Text(data['message']
                                                          .toString()),
                                                      Text(data.toString()),
                                                    ],
                                                  ),
                                                );
                                                
                                              }
                                            }
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            // validatingCredentials();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 35,
                          child: const Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget returnFormRow(String text, TextEditingController controller,
      Function setfunction, String getfunction, BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ).copyWith(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: text == "Email"
                  ? TextInputType.emailAddress
                  : text == "Mobile"
                      ? TextInputType.phone
                      : TextInputType.name,
              textInputAction:
                  text == "Email" ? TextInputAction.done : TextInputAction.next,
              onSubmitted: (value) {
                text == "Email"
                    ? FocusScope.of(context).dispose()
                    : FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                setfunction(value);
              },
              decoration: InputDecoration(
                hintText: text,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(bottom: 2, right: 0),
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ),
            ),
          ),
        ),
        Text(
          getfunction,
          style: _textTheme.headline6,
        ),
      ],
    );
  }
}

class ProfilePageFormProvider extends ChangeNotifier {
  String _firstNameError = "";
  String _lastNameError = "";
  String _mobileError = "";
  String _emailError = "";
  bool _emailErrorBool = false;
  bool _mobileErrorBool = false;

  //
  //setters
  setFirstNameError(String value) {
    if (value.isEmpty) {
      _firstNameError = "*You must enter a value.";
    }
    notifyListeners();
  }

  setLastNameError(String value) {
    if (value.isEmpty) {
      _lastNameError = "*You must enter a value.";
    }
    notifyListeners();
  }

  setEmailError(String value) {
    if (value.isEmpty) {
      _emailError = "*You must enter a value.";
      _emailErrorBool = true;
    }
    notifyListeners();
  }

  setMobileError(String value) {
    if (value.isEmpty) {
      _mobileError = "*You must enter a value.";
      _mobileErrorBool = true;
    } else {
      _mobileError = "";
      _mobileErrorBool = false;
    }
    notifyListeners();
  }

  //
  //getters
  get getFirstNameError {
    return _firstNameError;
  }

  get getLastNameError {
    return _lastNameError;
  }

  get getEmailError {
    return _emailError;
  }

  get getMobileError {
    return _mobileError;
  }

  get getMobileErrorBool {
    return _mobileErrorBool;
  }

  get getEmailErrorBool {
    return _emailErrorBool;
  }

  //Update Profile function
  static Future<Map<dynamic, dynamic>> updateProfile(
      String value1, String value2, String value3, String value4) async {
    var response =
        await http.post(Uri.parse(Constants.getUpdateProfileUrl), body: {
      "first_name": value1,
      "last_name": value2,
      "mobile": value3,
      "email": value4,
      "id": Constants.getStaffID
    } // need to use Constants.getStaffID in place of "8"
            );
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }
}
