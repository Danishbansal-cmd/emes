import 'dart:convert';
import 'package:emes/Pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //initializing loginform getx controller
    final loginFormController = Get.put(LoginFormController());
    print(
        "to check how many times does it run\nto check how many times does it run\nto check how many times does it run\nto check how many times does it run\nto check how many times does it run\n");

    final _textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.blue],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: const Center(
                            child: Text("some text"),
                          ),
                          height: 360,
                        ),
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "assets/icon.png",
                                scale: 1.75,
                              ),
                              const Text.rich(
                                TextSpan(
                                  text: "E",
                                  children: [
                                    TextSpan(
                                      text: "M",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    TextSpan(text: "ES"),
                                  ],
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 83, 83, 83),
                                      blurRadius: 3,
                                      spreadRadius: 0,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                // height: 350,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //
                                    //staff login row
                                    const Center(
                                      child: Text(
                                        "Staff Login",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //
                                    //username row
                                    returnFormRow(
                                        "Username",
                                        usernameController,
                                        loginFormController.setUsernameError,
                                        context),
                                    Obx(
                                      () => Text(
                                        loginFormController.getUsernameError,
                                        style: _textTheme.headline6,
                                      ),
                                    ),
                                    //
                                    //password row
                                    returnFormRow(
                                        "Password",
                                        passwordController,
                                        loginFormController.setPasswordError,
                                        context),
                                    Obx(
                                      () => Text(
                                        loginFormController.getPasswordError,
                                        style: _textTheme.headline6,
                                      ),
                                    ),
                                    //
                                    //companyID row
                                    returnFormRow(
                                        "CompanyID",
                                        companyIDController,
                                        loginFormController.setCompanyIDError,
                                        context),
                                    Obx(
                                      () => Text(
                                        loginFormController.getCompanyIDError,
                                        style: _textTheme.headline6,
                                      ),
                                    ),
                                    //
                                    //sign in button row
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                      child: InkWell(
                                        // splashColor: Colors.white,
                                        onTap: () {
                                          var a = loginFormController
                                              .validateApplyLeave(
                                                  usernameController.text,
                                                  passwordController.text,
                                                  companyIDController.text,
                                                  context);
                                          // validateApplyLeave(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 30,
                                          child: const Center(
                                            child: Text(
                                              "Sign In",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // focusColor: Colors.yellow,
                              // highlightColor: Colors.transparent,
                              // overlayColor: Colors.blue,
                              splashColor: Colors.blue[300],
                              borderRadius: BorderRadius.circular(3),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, MyRoutes.signupPageRoute);
                              },
                              child: Container(
                                height: 20,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget returnFormRow(String text, TextEditingController controller,
      Function setfunction, BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ).copyWith(right: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: TextField(
            cursorColor: Colors.grey,
            controller: controller,
            keyboardType: text == "Username"
                ? TextInputType.emailAddress
                : TextInputType.name,
            textInputAction: text == "CompanyID"
                ? TextInputAction.done
                : TextInputAction.next,
            onSubmitted: (value) {
              text == "CompanyID"
                  ? FocusScope.of(context).dispose()
                  : FocusScope.of(context).nextFocus();
            },
            onChanged: (value) {
              setfunction(value);
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: text == "CompanyID" ? text : "Your $text",
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

class LoginFormController extends GetxController {
  RxString _usernameError = "".obs;
  RxString _passwordError = "".obs;
  RxString _companyIDError = "".obs;

  //getters and setters
  get getUsernameError {
    return _usernameError.value;
  }

  get getPasswordError {
    return _passwordError.value;
  }

  get getCompanyIDError {
    return _companyIDError.value;
  }

  setUsernameError(String value) {
    if (value.isEmpty) {
      _usernameError.value = "*You must enter a value.";
    } else {
      _usernameError.value = "";
    }
  }

  setPasswordError(String value) {
    if (value.isEmpty) {
      _passwordError.value = "*You must enter a value.";
    } else {
      _passwordError.value = "";
    }
  }

  setCompanyIDError(String value) {
    if (value.isEmpty) {
      _companyIDError.value = "*You must enter a value.";
    } else {
      _companyIDError.value = "";
    }
  }

  //
  //some functions
  Future<String> getDataAboutCompanyURL(
      String paramCompanyURL, BuildContext context) async {
    var response = await http.post(
      Uri.parse('http://emesau.com/api/get_info'),
      body: {"companyID": paramCompanyURL},
    );
    var jsonData = jsonDecode(response.body);
    var companyURL = jsonData['companyURL'];
    if (companyURL != false) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('sharedDataCompanyURL', companyURL);
      Constants.setCompanyURL(companyURL);
      return companyURL;
    }
    return "false";
  }

  getData(
      String value1, String value2, String value3, BuildContext context) async {
    var companyURL = await getDataAboutCompanyURL(value3, context);
    if (companyURL == "false") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong companyID"),
        ),
      );
    } else {
      var response = await http.post(
        Uri.parse(companyURL + '/api/login'),
        body: {
          "email": value1,
          "password": value2,
          "companyID": value3,
        },
      );

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var jsonData = jsonDecode(response.body);
      String sharedData = jsonEncode(jsonData['data']);
      print("jsonData $jsonData");
      if (jsonData['status'] == 200) {
        print("Signed In Successfully.");
        Constants.setFirstName(jsonData['data']['first_name']);
        Constants.setLastName(jsonData['data']['last_name']);
        Constants.setEmail(jsonData['data']['email']);
        Constants.setStaffID(jsonData['data']['id']);
        Constants.setData(jsonData['data']);
        sharedPreferences.setString("token", jsonData['data']['token']);
        sharedPreferences.setString("staffID", jsonData['data']['id']);
        sharedPreferences.setString("sharedDataCompanyID", value3);
        sharedPreferences.setString("data", sharedData);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
            builder: (context) => HomePage(),
          ),
        );
      }
      if (jsonData['status'] == 401) {
        print("Wrong Username or Password You entered.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wrong Username or Password You entered."),
          ),
        );
      }
      // else{
      //   print("Something Went Wrong.");
      // }
    }
  }

  validateApplyLeave(
      String value1, String value2, String value3, BuildContext context) async {
    setUsernameError(value1);
    setPasswordError(value2);
    setCompanyIDError(value3);
    // if(value1.isEmpty){
    //   setUsernameError("*You must enter a value.");
    // }
    // if(value2.isEmpty){
    //   setPasswordError("*You must enter a value.");
    // }
    // if(value3.isEmpty){
    //   setCompanyIDError("*You must enter a value.");
    // }
    if (value1.isNotEmpty && value2.isNotEmpty && value3.isNotEmpty) {
      getData(value1, value2, value3, context);
    }
  }
}
