import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = Constants.getFirstName;
    lastNameController.text = Constants.getLastName;
    emailController.text = Constants.getEmail;
    mobileController.text = Constants.getStaffID;
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
                const Text("First Name"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Consumer<ProfilePageFormProvider>(
                      builder: (context, profilePageFormProvider, child) {
                        return TextField(
                          onChanged: (value) {
                            profilePageFormProvider.setFirstNameError(value);
                          },
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            // labelText: "hello 1",
                            hintText: "Your First Name",
                            border: InputBorder.none,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return Text(
                      profilePageFormProvider.getFirstNameError,
                      style: _textTheme.headline6,
                    );
                  },
                ),
                const Text("Last Name"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Center(
                    child: Consumer<ProfilePageFormProvider>(
                      builder: (context, profilePageFormProvider, _) {
                        return TextField(
                          onChanged: (value) {
                            profilePageFormProvider.setLastNameError(value);
                          },
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            // labelText: "hello 1",
                            hintText: "Your Last Name",
                            border: InputBorder.none,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return Text(
                      profilePageFormProvider.getLastNameError,
                      style: _textTheme.headline6,
                    );
                  },
                ),
                const Text("Mobile"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Center(
                    child: Consumer<ProfilePageFormProvider>(
                      builder: (context, profilePageFormProvider, _) {
                        return TextField(
                          onChanged: (value) {
                            profilePageFormProvider.setMobileError(value);
                          },
                          controller: mobileController,
                          decoration: const InputDecoration(
                            // labelText: "hello 1",
                            hintText: "Your Mobile Number",
                            border: InputBorder.none,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Consumer<ProfilePageFormProvider>(
                  builder: (context, profilePageFormProvider, _) {
                    return Text(
                      profilePageFormProvider.getMobileError,
                      style: _textTheme.headline6,
                    );
                  },
                ),
                const Text("Email"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Center(
                    child: Consumer<ProfilePageFormProvider>(
                      builder: (context, profilePageFormProvider, _) {
                        return TextField(
                          onChanged: (value){
                            profilePageFormProvider.setEmailError(value);
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            // labelText: "hello 1",
                            hintText: "Your Email",
                            border: InputBorder.none,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Consumer<ProfilePageFormProvider>(
                  builder: (context,
                      profilePageFormProvider, _) {
                    return Text(
                      profilePageFormProvider
                          .getEmailError,
                      style: _textTheme.headline6,
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    // splashColor: Colors.white,
                    onTap: () {
                      // validateApplyLeave(context);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePageFormProvider extends ChangeNotifier {
  String _firstNameError = "";
  String _lastNameError = "";
  String _mobileError = "";
  String _emailError = "";

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
    }
    notifyListeners();
  }

  setMobileError(String value) {
    if (value.isEmpty) {
      _mobileError = "*You must enter a value.";
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
}
