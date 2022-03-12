import 'package:emes/Providers/login_form_provider.dart';
import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(
        "to check how many times does it run\nto check how many times does it run\nto check how many times does it run\nto check how many times does it run\nto check how many times does it run\n");
    final loginFromProvider = Provider.of<LoginFormProvider>(context);
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
                  Container(
                    color: Colors.amber,
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
                          child: Center(
                            child: Text("some text"),
                          ),
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "emes".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                height: 350,
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
                                    Consumer<LoginFormProvider>(
                                      builder: (context,
                                          appLevelLoginFormProvider, _) {
                                        return returnFormRow(
                                            "Username",
                                            usernameController,
                                            appLevelLoginFormProvider
                                                .setUsernameError,
                                            appLevelLoginFormProvider
                                                .getUsernameError,
                                            context);
                                      },
                                    ),
                                    //
                                    //password row
                                    Consumer<LoginFormProvider>(
                                      builder: (context,
                                          appLevelLoginFormProvider, _) {
                                        return returnFormRow(
                                            "Password",
                                            passwordController,
                                            appLevelLoginFormProvider
                                                .setPasswordError,
                                            appLevelLoginFormProvider
                                                .getPasswordError,
                                            context);
                                      },
                                    ),
                                    //
                                    //companyID row
                                    // const Text("Company ID"),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Container(
                                    //   height: 40,
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 10,
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //     border: Border.all(
                                    //       color: Colors.black,
                                    //       width: 2,
                                    //     ),
                                    //   ),
                                    //   child: Center(
                                    //     child: TextField(
                                    //       textInputAction: TextInputAction.done,
                                    //       controller: companyIDController,
                                    //       onChanged: (value) {
                                    //         loginFromProvider
                                    //             .setCompanyIDError(value);
                                    //       },
                                    //       decoration: const InputDecoration(
                                    //         // labelText: "hello 1",
                                    //         hintText: "Company ID",
                                    //         border: InputBorder.none,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Consumer<LoginFormProvider>(
                                    //   builder: (context,
                                    //       appLevelLoginFormProvider, _) {
                                    //     return Text(
                                    //       appLevelLoginFormProvider
                                    //           .getCompanyIDError,
                                    //       style: _textTheme.headline6,
                                    //     );
                                    //   },
                                    // ),
                                    Consumer<LoginFormProvider>(
                                      builder: (context,
                                          appLevelLoginFormProvider, _) {
                                        return returnFormRow(
                                            "CompanyID",
                                            companyIDController,
                                            appLevelLoginFormProvider
                                                .setCompanyIDError,
                                            appLevelLoginFormProvider
                                                .getCompanyIDError,
                                            context);
                                      },
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
                                          var a = loginFromProvider
                                              .validateApplyLeave(
                                                  usernameController.text,
                                                  passwordController.text,
                                                  companyIDController.text,
                                                  context);
                                          // validateApplyLeave(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 35,
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
                    color: Colors.amber,
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
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            // focusColor: Colors.yellow,
                            highlightColor: Colors.transparent,
                            // overlayColor: Colors.blue,
                            splashColor: Colors.blue[100],
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
              keyboardType:text == "Username" ? TextInputType.emailAddress : TextInputType.name,
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
                hintText: text == "CompanyID" ? text : "Your $text",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  padding: const EdgeInsets.only(bottom: 2,right: 0),
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
