import 'package:flutter/material.dart';
import 'package:notes_app_flutter/components/drawer_tile.dart';
import 'package:notes_app_flutter/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //Header

          DrawerHeader(
            child: Icon(Icons.book, size: 40, color: Theme.of(context).colorScheme.inversePrimary),
          ),

          //Drawer Tile
          DrawerTile(
            title: "Notes",
             leading: Icon(Icons.home),
             onTap: () => {
                Navigator.pop(context),
              
             },
             ),

             DrawerTile(
            title: "Settings",
             leading: Icon(Icons.settings),
             onTap: () => {
                Navigator.pop(context),
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()))
              
             },
             )

        ],
      ),
    );
  }
}