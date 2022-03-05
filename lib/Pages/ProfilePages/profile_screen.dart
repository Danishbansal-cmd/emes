import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("First Name"),
        TextFormField(
          
        ),SizedBox(height: 10,),
        SizedBox(height: 10,),
        Text("Last Name"),
        TextFormField(),SizedBox(height: 10,),
        Text("Mobile"),
        TextFormField(),SizedBox(height: 10,),
        Text("Email"),
        TextFormField(),
      ],),
    );
  }
}