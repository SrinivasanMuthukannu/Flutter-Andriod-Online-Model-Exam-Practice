import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/services.dart';
import 'package:apple_sign_in/apple_sign_in.dart';


class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();
  final TextEditingController _Namecontroller = new TextEditingController();
  final TextEditingController _RollNumber = new TextEditingController();
  String _dropDownGenderValue,_dropdownCollegeValue,_dropdownBranchValue;
  bool _Namevalidate = false;
  bool _Rollnovalidate = false;

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
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
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           /* FlutterLogo(
              size: 150,
            ),*/
            Image.asset(
              'assets/covers/banner.jpg',
              fit: BoxFit.contain,
               // fit:BoxFit.fill
            ),
           /*Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),*/
            //Text('Your Tagline'),
            /*LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: FontAwesomeIcons.google,
              color: Colors.black45,
              loginMethod: auth.googleSignIn,
            ),*/
            FutureBuilder<Object>(
              future: auth.appleSignInAvailable,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return AppleSignInButton(
                    onPressed: () async { 
                      FirebaseUser user = await auth.appleSignIn();
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/topics');
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            _buildFormFields(),
            //LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
           /* LoginButton(
              text: 'START WITH SYASANS',
              icon: FontAwesomeIcons.userCircle,
              color: Colors.orangeAccent,
              loginMethod: auth.anonLogin,
            )*/
          ],
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
                  labelText: 'Student Name',
                errorText: _Namevalidate ? 'Value Can\'t Be Empty' : null,
              ),
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25.0,),
          new Container(
            child: new TextField(
              controller: _RollNumber,
              decoration: new InputDecoration(
                  labelText: 'Roll.No',
                errorText: _Rollnovalidate ? 'Value Can\'t Be Empty' : null,
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
         /* SizedBox(height: 25.0,),
          new  DropdownButton(
    hint: _dropDownGenderValue == null
    ? Text('Please Choose Gender')
        : Text(
      _dropDownGenderValue,
      style: TextStyle(
        color: Colors.white,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      ),
    ),
    isExpanded: true,
    iconSize: 30.0,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
    items: ['Male', 'Female'].map(
    (val) {
    return DropdownMenuItem<String>(
    value: val,
    child: Text(val),
    );
    },
    ).toList(),
    onChanged: (val) {
    setState(
    () {
      _dropDownGenderValue = val;
    },
    );
    },
    ),*/
          SizedBox(height: 25.0,),
          new  DropdownButton(
            hint: _dropdownCollegeValue == null
                ? Text('Please Choose College')
                : Text(
              _dropdownCollegeValue,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
            items: ['Desc', 'BITS','NSIT'].map(
                  (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                    () {
                      _dropdownCollegeValue = val;
                },
              );
            },
          ),
          SizedBox(height: 25.0,),
          new  DropdownButton(
            hint: _dropdownBranchValue == null
                ? Text('Please Choose Branch Name')
                : Text(
              _dropdownBranchValue,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
            items: ['CSE', 'ECE','EEE','IT','CIV','MBA','MCA'].map(
                  (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                    () {
                      _dropdownBranchValue = val;
                },
              );
            },
          ),
          SizedBox(height: 75.0,),
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
                  var user = await auth.anonLogin();
                  if (user != null) {
                    _updateUserReport(_Namecontroller.text,_RollNumber.text,_dropdownCollegeValue,_dropdownBranchValue);
                    Navigator.pushReplacementNamed(context, '/topics');
                  }
                }
            },
            child: Text('START WITH SYASANS'),
            textColor: Colors.white,
            color: Colors.orangeAccent,
          )
    ),
        ],
      ),
    );
  }

  Future<void> _updateUserReport(String sName,String sRollnumber,String sCollege,String sBranchName) {
    return Global.reportRef.upsert(
      ({
        'name': sName,
        'rollno':sRollnumber,
        'college': sCollege,
        'branch': sBranchName
      }),
    );
  }

}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
