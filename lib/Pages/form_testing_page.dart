import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';

class FormTestingPage extends StatelessWidget {
  FormTestingPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                        child: Center(
                          child: Text("some text"),
                        ),
                        height: MediaQuery.of(context).size.height / 3,
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
                              height: 400,
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
                                  const Text("Username"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: usernameController,
                                    // maxLines: 5,
                                    // minLines: 3,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 14,
                                      ),
                                      hintText: "Your Username",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length < 5) {
                                        return "potty";
                                      }
                                      return null;
                                    },
                                  ),
                                  //
                                  //password row
                                  const Text("Password"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                          // labelText: "hello 1",
                                          hintText: "Your Password",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // //
                                  // //companyID row
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
                                  //       controller: companyIDController,
                                  //       decoration:const InputDecoration(
                                  //         // labelText: "hello 1",
                                  //         hintText: "Company ID",
                                  //         border: InputBorder.none,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 10,
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
                  Text("form testing page"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
