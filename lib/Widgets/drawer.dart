import 'package:emes/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _colorScheme = Theme.of(context).colorScheme;
    const imageUrl =
        "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=";
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text("Nsothing"),
                accountEmail: Text("Nothing@nothingmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.homePageRoute);
              },
              child: ListTile(
                leading: Icon(Icons.calendar_month_outlined),
                title: Text(
                  "Roster",
                  style: _textTheme.headline2,
                ),
                // subtitle: Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.profilePageRoute);
              },
              child: ListTile(
                leading: const Icon(Icons.threed_rotation),
                title: Text(
                  "Profile",
                  style: _textTheme.headline2,
                ),
                // subtitle: const Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.applyLeavePageRoute);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.add_circle,
                ),
                title: Text(
                  "Apply Leave",
                  style: _textTheme.headline2,
                ),
                // subtitle:const Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.inboxPageRoute);
              },
              child: ListTile(
                leading: const Icon(Icons.forum),
                title: Text(
                  "Inbox",
                  style: _textTheme.headline2,
                ),
                // subtitle:const  Text("Subtitle Please"),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              
                            ),
                            height: 300,
                            child: Column(
                              children: [
                                Text("Confirm!"),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    "Are you sure want to logout of this app?"),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: _textTheme.headline2,
                ),
                // subtitle:const Text("Subtitle Please"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {}
}
