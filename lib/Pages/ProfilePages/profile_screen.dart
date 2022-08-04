import 'dart:convert';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:emes/Utils/get_logged_in_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //buillevel controller initialize
  final _profilePageFormController = Get.put(ProfilePageFormController());
  @override
  void initState() {
    super.initState();
    callFunction();
  }

  callFunction() async {
    List profileData = await GetLoggedInUserInformation.getData();
    firstNameController.text = profileData[0];
    lastNameController.text = profileData[1];
    mobileController.text = profileData[2];
    emailController.text = profileData[3];
    _profilePageFormController.setFirstNameError(firstNameController.text);
    _profilePageFormController.setLastNameError(lastNameController.text);
    _profilePageFormController.setMobileError(mobileController.text);
    _profilePageFormController.setEmailError(emailController.text);
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final ConfigurePlatform _configurePlatform = ConfigurePlatform();

  @override
  Widget build(BuildContext context) {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    final _textTheme = Theme.of(context).textTheme;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.all(16).copyWith(bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              //First Name row
              returnFormRowOBX("First Name", firstNameController,
                  _profilePageFormController.setFirstNameError, context),
              Obx(
                () => Text(
                  _profilePageFormController.getFirstNameError.value,
                  style: _textTheme.headline6,
                ),
              ),
              //
              //Last Name row
              returnFormRowOBX("Last Name", lastNameController,
                  _profilePageFormController.setLastNameError, context),
              Obx(
                () => Text(
                  _profilePageFormController.getLastNameError.value,
                  style: _textTheme.headline6,
                ),
              ),
              //
              //Mobile row
              returnFormRowOBX("Mobile", mobileController,
                  _profilePageFormController.setMobileError, context),
              Obx(
                () => Text(
                  _profilePageFormController.getMobileError.value,
                  style: _textTheme.headline6,
                ),
              ),
              //
              //Email row
              returnFormRowOBX("Email", emailController,
                  _profilePageFormController.setEmailError, context),
              Obx(
                () => Text(
                  _profilePageFormController.getEmailError.value,
                  style: _textTheme.headline6,
                ),
              ),
              //
              //Update Button
              const SizedBox(
                height: 15,
              ),
              (_isIos)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        onPressed: () {
                          _profilePageFormController
                              .setFirstNameError(firstNameController.text);
                          _profilePageFormController
                              .setLastNameError(lastNameController.text);
                          _profilePageFormController
                              .setMobileError(mobileController.text);
                          _profilePageFormController
                              .setEmailError(emailController.text);

                          if (firstNameController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty &&
                              _profilePageFormController.getMobileErrorBool ==
                                  false &&
                              _profilePageFormController.getEmailErrorBool ==
                                  false) {
                            showDialog<void>(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Update"),
                                  content: FutureBuilder(
                                    future: _profilePageFormController
                                        .updateProfile(
                                      firstNameController.text,
                                      lastNameController.text,
                                      mobileController.text,
                                      emailController.text,
                                    ),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Text('Error occured');
                                        } else if (snapshot.hasData) {
                                          final data = snapshot.data as Map;
                                          if (data['status'] == 200) {
                                            Constants.setFirstName(
                                                firstNameController.text);
                                            Constants.setLastName(
                                                lastNameController.text);
                                            Constants.setMobile(
                                                mobileController.text);
                                            Constants.setEmail(
                                                emailController.text);
                                          }
                                          return const Text(
                                              "User Profile Updated");
                                        }
                                      }
                                      return const CupertinoActivityIndicator();
                                    },
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text("cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Update'),
                      ),
                    )
                  : Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: () {
                          _profilePageFormController
                              .setFirstNameError(firstNameController.text);
                          _profilePageFormController
                              .setLastNameError(lastNameController.text);
                          _profilePageFormController
                              .setMobileError(mobileController.text);
                          _profilePageFormController
                              .setEmailError(emailController.text);

                          if (firstNameController.text.isNotEmpty &&
                              lastNameController.text.isNotEmpty &&
                              _profilePageFormController.getMobileErrorBool ==
                                  false &&
                              _profilePageFormController.getEmailErrorBool ==
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
                                            horizontal: 30),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        height: 80,
                                        child: FutureBuilder(
                                          future: _profilePageFormController
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
                                                    const Duration(
                                                      milliseconds: 500,
                                                    ), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });
                                                return const SingleChildScrollView(
                                                  child: Text(
                                                    'Error occured',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                Future.delayed(
                                                    const Duration(
                                                      milliseconds: 1000,
                                                    ), () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                });

                                                final data =
                                                    snapshot.data as Map;
                                                if (data['status'] == 200) {
                                                  Constants.setFirstName(
                                                      firstNameController.text);
                                                  Constants.setLastName(
                                                      lastNameController.text);
                                                  Constants.setMobile(
                                                      mobileController.text);
                                                  Constants.setEmail(
                                                      emailController.text);
                                                }
                                                return const Center(
                                                  child: Text(
                                                    "User Profile Updated",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                );
                                              }
                                            }
                                            return Center(
                                              child: (_isIos)
                                                  ? const CupertinoActivityIndicator(
                                                      radius: 20.0,
                                                      color: Colors.black)
                                                  : const CircularProgressIndicator(
                                                      color: Colors.blue,
                                                    ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 35,
                          child: Center(
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
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget returnFormRowOBX(String text, TextEditingController controller,
      Function setfunction, BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        (_isIos)
            ? CupertinoTextField(
                enableInteractiveSelection: true,
                controller: controller,
                keyboardType: text == "Email"
                    ? TextInputType.emailAddress
                    : text == "Mobile"
                        ? TextInputType.phone
                        : TextInputType.name,
                textInputAction: TextInputAction.done,
                placeholder: "Enter $text",
                suffix: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.clear();
                  },
                  child: const Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                onChanged: (value) {
                  setfunction(value);
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.extraLightBackgroundGray,
                  border: Border.all(
                    color: CupertinoColors.lightBackgroundGray,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                cursorColor: CupertinoColors.activeOrange,
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(right: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary,
                    width: 2,
                  ),
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.grey,
                  enableInteractiveSelection: false,
                  controller: controller,
                  keyboardType: text == "Email"
                      ? TextInputType.emailAddress
                      : text == "Mobile"
                          ? TextInputType.phone
                          : TextInputType.name,
                  textInputAction: text == "Email"
                      ? TextInputAction.done
                      : TextInputAction.next,
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
                      color: Colors.grey,
                      padding: const EdgeInsets.only(bottom: 2, right: 0),
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class ProfilePageFormController extends GetxController {
  RxString _firstNameError = "".obs;
  RxString _lastNameError = "".obs;
  RxString _mobileError = "".obs;
  RxString _emailError = "".obs;
  RxBool _emailErrorBool = false.obs;
  RxBool _mobileErrorBool = false.obs;

  //
  //setters
  setFirstNameError(String value) {
    if (value.isEmpty) {
      _firstNameError.value = "*You must enter a value.";
    } else {
      _firstNameError.value = "";
    }
  }

  setLastNameError(String value) {
    if (value.isEmpty) {
      _lastNameError.value = "*You must enter a value.";
    } else {
      _lastNameError.value = "";
    }
  }

  setEmailError(String value) {
    if (value.isEmpty) {
      _emailError.value = "*You must enter a value.";
      _emailErrorBool.value = true;
    } else {
      _emailError.value = "";
      _emailErrorBool.value = false;
    }
  }

  setMobileError(String value) {
    if (value.isEmpty) {
      _mobileError.value = "*You must enter a value.";
      _mobileErrorBool.value = true;
    } else {
      _mobileError.value = "";
      _mobileErrorBool.value = false;
    }
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
  Future<Map<dynamic, dynamic>> updateProfile(
      String value1, String value2, String value3, String value4) async {
    var response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/update_profile'),
        body: {
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
