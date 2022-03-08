import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll){
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
                child: const Center(
                  child: TextField(
                    // controller: fromDateController,
                    decoration: InputDecoration(
                      // labelText: "hello 1",
                      hintText: "Your First Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Consumer<ApplyLeaveFormProvider>(
              //   builder: (context,
              //       appLevelApplyLeaveFormProvider, _) {
              //     return Text(
              //       appLevelApplyLeaveFormProvider
              //           .getFromDateErrorText,
              //       style: _textTheme.headline6,
              //     );
              //   },
              // ),
              SizedBox(
                height: 10,
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
                  child: TextField(
                    // controller: fromDateController,
                    decoration: const InputDecoration(
                      // labelText: "hello 1",
                      hintText: "Your Last Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Consumer<ApplyLeaveFormProvider>(
              //   builder: (context,
              //       appLevelApplyLeaveFormProvider, _) {
              //     return Text(
              //       appLevelApplyLeaveFormProvider
              //           .getFromDateErrorText,
              //       style: _textTheme.headline6,
              //     );
              //   },
              // ),
              SizedBox(
                height: 10,
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
                  child: TextField(
                    // controller: fromDateController,
                    decoration: const InputDecoration(
                      // labelText: "hello 1",
                      hintText: "Your Mobile Number",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Consumer<ApplyLeaveFormProvider>(
              //   builder: (context,
              //       appLevelApplyLeaveFormProvider, _) {
              //     return Text(
              //       appLevelApplyLeaveFormProvider
              //           .getFromDateErrorText,
              //       style: _textTheme.headline6,
              //     );
              //   },
              // ),
              SizedBox(
                height: 10,
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
                child: const Center(
                  child: TextField(
                    // controller: fromDateController,
                    decoration: InputDecoration(
                      // labelText: "hello 1",
                      hintText: "Your Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Consumer<ApplyLeaveFormProvider>(
              //   builder: (context,
              //       appLevelApplyLeaveFormProvider, _) {
              //     return Text(
              //       appLevelApplyLeaveFormProvider
              //           .getFromDateErrorText,
              //       style: _textTheme.headline6,
              //     );
              //   },
              // ),
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
    );
  }
}
