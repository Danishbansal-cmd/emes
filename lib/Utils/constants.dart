import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static late String _firstName;
  static late String _lastName;
  static late String _email;
  static late String _mobile;
  static late String _staffID;
  static late Map _dataLogIN;
  static late String _companyURL;

  //
  //setters
  static setFirstName(String value) {
    _firstName = value;
  }

  static setLastName(String value) {
    _lastName = value;
  }

  static setEmail(String value) {
    _email = value;
  }

  static setStaffID(String value) {
    _staffID = value;
  }

  static setData(Map value) {
    _dataLogIN = value;
  }

  static setMobile(String value) {
    _mobile = value;
  }

  static setCompanyURL(String value) {
    _companyURL = value;
  }

  //
  //getters
  static get getFirstName {
    return _firstName;
  }

  static get getLastName {
    return _lastName;
  }

  static get getStaffID {
    return _staffID;
  }

  static get getEmail {
    return _email;
  }

  static get getData {
    return _dataLogIN;
  }

  static get getMobile {
    return _mobile;
  }

  static get getCompanyURL {
    return _companyURL;
  }

  //
  //Day of Shifts

  static String nameOfDayOfShift(String value) {
    if (value == "1") {
      return "Monday".substring(0, 3);
    } else if (value == "2") {
      return "Tuesday".substring(0, 3);
    } else if (value == "3") {
      return "Wednesday".substring(0, 3);
    } else if (value == "4") {
      return "Thursday".substring(0, 3);
    } else if (value == "5") {
      return "Friday".substring(0, 3);
    } else if (value == "6") {
      return "Saturday".substring(0, 3);
    } else if (value == "0") {
      return "Sunday".substring(0, 3);
    }
    return "Error";
  }

  static Widget indicatorTracker(Color color, double value) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              height: 30,
              width: 7,
              color: color,
            ),
          ],
        ),
        Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 15, minHeight: 15, minWidth: 15, maxWidth: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(
              height: value.toDouble(),
            ),
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 15, minHeight: 15, minWidth: 15, maxWidth: 15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future basicWidget(String value, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(
            milliseconds: 1200,
          ),
          () {
            Navigator.of(context).pop(true);
          },
        );
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget declineShiftPopupTopRow(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
        Material(
          color: const Color.fromARGB(0, 199, 38, 38),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor: Colors.grey,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              width: 35,
              height: 35,
              child: Icon(
                Icons.close_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget textfieldWithCancelSuffixButton(
      Function onchangeFunction, TextEditingController controller) {
    return Container(
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
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          onchangeFunction(value);
        },
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Give Reason",
          border: InputBorder.none,
          suffixIcon: SizedBox(
            width: 40,
            child: IconButton(
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
    );
  }

  static Widget materialRoundedButton(
      {required Color baseColor,
      Color? highlightColor,
      Color? splashColor,
      required Function onTapFunction,
      required String buttonText}) {
    return Material(
      color: baseColor,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        highlightColor: highlightColor,
        splashColor: splashColor,
        onTap: () {
          onTapFunction();
        },
        child: Container(
          width: double.infinity,
          height: 35,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future showCupertinoAlertDialog(
      {required Widget child, required BuildContext context}) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Note"),
          content: child,
          actions: [
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Widget setReasonCupertinoTextField({required BuildContext context, required int maxlines, required TextEditingController controller, required Function onChanged}) {
    return CupertinoTextField(
      textInputAction: TextInputAction.done,
      maxLines: maxlines,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      enableInteractiveSelection: false,
      controller: controller,
      cursorColor: CupertinoColors.activeOrange,
      onChanged: (value) {
        onChanged(value);
      },
      placeholder: "Enter your Reason",
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
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
