import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(child:
      new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0,),
            Image.asset(
              'assets/covers/banner.jpg',
              fit: BoxFit.contain,
              // fit:BoxFit.fill
            ),
            SizedBox(height: 50.0,),
            Text(
              'WELCOME',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50.0,),            // The button on pressed, logs-in the user to and shows Home Page

            SizedBox.fromSize(
              size: Size(170, 170), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.orange, // button color
                  child: InkWell(
                    splashColor: Colors.green, // splash color
                    onTap: ()=>
                      Navigator.of(context).pushReplacementNamed("/testlogin"), // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.airplay,size: 40.0), // icon
                        Text("LearnUp",style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox.fromSize(
              size: Size(170, 170), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.orange, // button color
                  child: InkWell(
                    splashColor: Colors.green, // splash color
                    onTap: () => Navigator.of(context).pushNamed("/admin"), // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.account_circle,size: 40.0), // icon
                        Text("Admin Panel",style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /*new RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/testlogin"),
                  child: new Text("Take Me to Test"),
                textColor: Colors.white,
                color: Colors.orangeAccent,
            ),*/


            // Takes user to sign up page
            /*new RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed("/admin"),
                child: new Text("Take Me to Admin Panel"),
              textColor: Colors.white,
              color: Colors.orangeAccent,

            ),*/

            // Takes user to forgot password page

          ],
        ),
      ),
      ),
    );
  }
}
