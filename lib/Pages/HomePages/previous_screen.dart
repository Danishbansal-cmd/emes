import 'package:emes/Utils/shift_data.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({ this.setStateValue = "nothing" , Key? key }) : super(key: key);
  String setStateValue;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  
  @override
  void initState(){
    super.initState();
    print(this.widget.setStateValue);
  }

  @override
  Widget build(BuildContext context) {
    // print("this is text ${this.widget.setStateValue}");
    return Container(
      // color: Colors.red,
      child: Center(
        child: FutureBuilder(
          future: ShiftData.getPreviousData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                // final data = snapshot.data as String;
                final shiftData = snapshot.data['allShifts'] as List;

                return shiftData.isEmpty
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 90,
                            color: Colors.blue,
                          ),
                          const Text("No Shifts Found"),
                          Text(snapshot.data['shift_title']),
                        ],
                      )
                    : ListView.builder(
                        itemCount: shiftData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.ad_units),
                            trailing: const Text("HEY"),
                            title: Text("List item $index"),
                          );
                        },
                      );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}