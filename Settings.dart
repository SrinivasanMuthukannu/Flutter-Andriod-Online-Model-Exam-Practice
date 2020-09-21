import 'package:flutter/material.dart';
import '../services/services.dart';
import 'package:quizapp/form_controller.dart';
import 'MyDrawer.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => new SettingScreenState();
}

class SettingScreenState extends  State<SettingScreen> {
  final AuthService auth = AuthService();
  bool _load = false;
  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    return Scaffold(
      appBar: AppBar(
          title: Text('Admin Settings'),
          backgroundColor: Colors.deepPurple,
       /* leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            }
        ),*/
       actions: <Widget>[
      Padding(
      padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () async {
            await auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: Icon(
            Icons.settings_power,
            size: 26.0,
          ),
        )
    )],
      ),

      drawer: MyDrawer(),
      body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FlatButton.icon(
          label: Text('Sync data with Cloud'),
          icon : Icon(Icons.cloud_upload),
          color: Colors.orangeAccent,
          onPressed: () async {
            setState((){
              _load=true;
            });
            print("Data uploading");
            FormController formController = FormController((String response) {
              print("Response: $response");
              if (response == FormController.STATUS_SUCCESS) {
                // _showSnackbar("Feedback Submitted");
                _showSucessAlert(context, "Data has been uploaded");
                print("Data Uploaded");
                setState((){
                  _load=false;
                });
              } else {
                // Error Occurred while saving data in Google Sheets.
                _showErrorAlert(context, "Error Occurred while saving data from Google Sheets");
                print("Error Occurred!");
                setState((){
                  _load=false;
                });
              }
            }
            );
            //_showSnackbar("Submitting Feedback");
            print("Submitting Feedback");
            // Submit 'DataSync' and save it in Google Sheets.
            formController.submitDataSync();

          }),
      new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
      ],
      ),
      ),
    );
  }

  void _showErrorAlert(BuildContext context,String messages) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error",style: TextStyle(fontSize: 18, color: Colors.red,letterSpacing: 1.5,
              fontWeight: FontWeight.bold),),
          content: Text(messages,style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold)),
        )
    );
  }
  void _showSucessAlert(BuildContext context,String messages) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success",style: TextStyle(fontSize: 18, color: Colors.green,letterSpacing: 1.5,
              fontWeight: FontWeight.bold),),
          content: Text(messages,style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold)),
        )
    );
  }
}