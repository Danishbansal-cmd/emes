import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=";
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName:  Text("Nsothing"),
                accountEmail: Text("Nothing@nothingmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: Text("Roster",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff414141),
                fontSize: 16
              ),),
              // subtitle: Text("Subtitle Please"),
            ),ListTile(
              leading: Icon(Icons.threed_rotation),
              title: Text("Profile"),
              subtitle: Text("Subtitle Please"),
            ),ListTile(
              leading: Icon(Icons.add_circle,),
              title: Text("Apply Leave"),
              subtitle: Text("Subtitle Please"),
            ),ListTile(
              leading: Icon(Icons.forum),
              title: Text("Inbox"),
              subtitle: Text("Subtitle Please"),
            ),ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              subtitle: Text("Subtitle Please"),
            )
          ],
        ),
      ),
    );
  }
}
