import 'package:emes/Providers/sign_up_form_provider.dart';
import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
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
                        height: 520,
                      ),
                      Column(
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
                                  color: Colors.grey,
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
                            height: 500,
                            child: ChangeNotifierProvider<SignupFormProvider>(
                              create: (_) => SignupFormProvider(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  //staff login row
                                  const Center(
                                    child: Text(
                                      "Staff Register",
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
                                  //firstname row
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return returnFormRow(
                                          "First Name",
                                          firstNameController,
                                          appLevelSignupFormProvider
                                              .setFirstNameError,
                                          appLevelSignupFormProvider
                                              .getFirstNameError,
                                          context);
                                    },
                                  ),
                                  //
                                  //Last row
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return returnFormRow(
                                          "Last Name",
                                          lastNameController,
                                          appLevelSignupFormProvider
                                              .setLastNameError,
                                          appLevelSignupFormProvider
                                              .getLastNameError,
                                          context);
                                    },
                                  ),
                                  //
                                  //mobile number row
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return returnFormRow(
                                          "Mobile",
                                          mobileController,
                                          appLevelSignupFormProvider
                                              .setMobileError,
                                          appLevelSignupFormProvider
                                              .getMobileError,
                                          context);
                                    },
                                  ),
                                  //
                                  //Email row
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return returnFormRow(
                                          "Email",
                                          emailController,
                                          appLevelSignupFormProvider
                                              .setEmailError,
                                          appLevelSignupFormProvider
                                              .getEmailError,
                                          context);
                                    },
                                  ),
                                  //
                                  //CompanyID row
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return returnFormRow(
                                          "CompanyID",
                                          companyIDController,
                                          appLevelSignupFormProvider
                                              .setCompanyIDError,
                                          appLevelSignupFormProvider
                                              .getCompanyIDError,
                                          context);
                                    },
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Consumer<SignupFormProvider>(
                                    builder: (context,
                                        appLevelSignupFormProvider, _) {
                                      return Material(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(50),
                                        child: InkWell(
                                          // splashColor: Colors.white,
                                          onTap: () {
                                            appLevelSignupFormProvider
                                                .validateSignUpForm(
                                              firstNameController.text,
                                              lastNameController.text,
                                              mobileController.text,
                                              emailController.text,
                                              companyIDController.text,
                                              context,
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            child: const Center(
                                              child: Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
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
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Already have an account?",
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
                                  context, MyRoutes.loginPageRoute);
                            },
                            child: Container(
                              height: 20,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: const Text(
                                "Login",
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
                ],
              ),
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
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: text == "Mobile"
                  ? TextInputType.number
                  : text == "Email"
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
