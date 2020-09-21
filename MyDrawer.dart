import 'package:flutter/material.dart';

const String _AccountName = 'Srinivasan M';
const String _AccountEmail = 'Admin Account';
const String _AccountAbbr = 'Syasan';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            //accountName: const Text(_AccountName),
            accountEmail: const Text(_AccountEmail,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
            currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.brown,
                child: new Text(_AccountAbbr,style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ))
            ),
          ),
          new ListTile(
              leading: new Icon(Icons.cloud_upload),
              title: new Text('Data Import'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/settings');
              }
          ),
          new ListTile(
              leading: new Icon(Icons.supervised_user_circle),
              title: new Text('Users'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/Users');
              }
          ),
          new ListTile(
              leading: new Icon(Icons.report),
              title: new Text('Reports'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/Report');
              }
          ),
          new Divider(),
          new ListTile(
              leading: new Icon(Icons.help),
              title: new Text('Help & feedback'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/Help');
              })
        ],
      ),
    );
  }
}