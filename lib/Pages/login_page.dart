import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
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
                                    controller: usernameController,
                                    decoration:const InputDecoration(
                                      // labelText: "hello 1",
                                      hintText: "Your Username",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
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
                                    decoration:const InputDecoration(
                                      // labelText: "hello 1",
                                      hintText: "Your Password",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              //
                              //companyID row
                              const Text("Company ID"),
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
                                    controller: companyIDController,
                                    decoration:const InputDecoration(
                                      // labelText: "hello 1",
                                      hintText: "Company ID",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30,),
                child: Column(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        
                      ),
                    ),
                    SizedBox(height: 6,),
                    InkWell(
                      // focusColor: Colors.yellow,
                      highlightColor: Colors.transparent,
                      // overlayColor: Colors.blue,
                      splashColor: Colors.blue[100],
                      borderRadius: BorderRadius.circular(3),
                      onTap: (){
                        Navigator.pushReplacementNamed(context, MyRoutes.signupPageRoute);
                      },
                      child: Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 10,),
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
    );
  }
}
