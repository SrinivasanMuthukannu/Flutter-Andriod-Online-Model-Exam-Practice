import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/services.dart';
import 'package:apple_sign_in/apple_sign_in.dart';


class AdminScreen extends StatefulWidget {
  createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> {
  AuthService auth = AuthService();
  final TextEditingController _Namecontroller = new TextEditingController();
  final TextEditingController _RollNumber = new TextEditingController();
  bool _Namevalidate = false;
  bool _Rollnovalidate = false;

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
          (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/settings');
        }
      },
    );
    _Namecontroller.addListener(_ValidatetxtNameValue);
    _RollNumber.addListener(_ValidatetxtrollnumberValue);
  }
  _ValidatetxtNameValue() {
    setState(() {
      _Namecontroller.text.isEmpty ? _Namevalidate = true : _Namevalidate = false;

    });
  }
  _ValidatetxtrollnumberValue() {
    setState(() {
      _RollNumber.text.isEmpty ? _Rollnovalidate = true : _Rollnovalidate = false;
    });
  }

  @override
  void dispose() {
    _Namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(child:
        Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/covers/banner.jpg',
              fit: BoxFit.contain,
              // fit:BoxFit.fill
            ),
            SizedBox(height: 25.0,),
            Text(
              'Admin Panel',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            FutureBuilder<Object>(
              future: auth.appleSignInAvailable,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return AppleSignInButton(
                    onPressed: () async {
                      FirebaseUser user = await auth.appleSignIn();
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/settings');
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(height: 25.0,),
            _buildFormFields(),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildFormFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child:
            new TextField(
              controller: _Namecontroller,
              decoration: new InputDecoration(
                labelText: 'Email',
                errorText: _Namevalidate ? 'Value Can\'t Be Empty' : null,
              ),
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          new Container(
            child: new TextField(
              controller: _RollNumber,
              decoration: new InputDecoration(
                labelText: 'Password',
                errorText: _Rollnovalidate ? 'Value Can\'t Be Empty' : null,
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          new ButtonTheme(
              minWidth: 400.0,
              height: 50.0,
              child:
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    _Namecontroller.text.isEmpty ? _Namevalidate = true : _Namevalidate = false;
                    _RollNumber.text.isEmpty ? _Rollnovalidate = true : _Rollnovalidate = false;
                  });
                  if(!_Namevalidate&&!_Rollnovalidate)
                  {
                    var user = await auth.signIn(_Namecontroller.text,_RollNumber.text);
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, '/settings');
                    }else{
                      _showAlert(context);
                    }

                  }
                },
                child: Text('START WITH ADMIN'),
                textColor: Colors.white,
                color: Colors.orangeAccent,
              )
          ),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid user",style: TextStyle(fontSize: 18, color: Colors.red,letterSpacing: 1.5,
              fontWeight: FontWeight.bold),),
          content: Text("User not detected. Please activate it.",style: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold)),
        )
    );
  }

}


