import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/form_controller.dart';
//import 'package:flutter_youtube/flutter_youtube.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:async';

// Shared Data
class QuizState with ChangeNotifier {
  double _progress = 0;
  Option _selected;
  List<String> lstCorrectItems = [];
  final PageController controller = PageController();

  get progress => _progress;
  get selected => _selected;


  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }


  set selected(Option newValue) {
    _selected = newValue;
    bool correct = newValue.correct;
    if(correct) {
      lstCorrectItems.add(newValue.value);
      //print(lstCorrectItems.length);
    }
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // Timer
  Timer _timer;
  int _start = 0;
  get start => _start;
  //get startTimer => _start;
  void startTimer() {
    print("started at "+_start.toString());
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      print("cancel timer at 1");
    }
    else {
      _timer = new Timer.periodic(Duration(seconds: 60), (timer) {
        // print(DateTime.now());
        if (_start < 1) {
          timer.cancel();
          timer =null;
          print("cancel timer");
          //notifyListeners();
        } else {
          _start = _start - 1;
          print(_start);
          //start(_start);
          notifyListeners();
        }
      });
    }
    notifyListeners();
    nextPage();
  }
  // constructor
  QuizState(this._start);

}

class QuizScreen extends StatelessWidget {
  QuizScreen({this.quizId,this.quiztime});
  final String quizId;
  final int quiztime;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(quiztime),
      child: FutureBuilder(
        future: Document<Quiz>(path: 'quizzes/$quizId').getData(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          var state = Provider.of<QuizState>(context); // k

          if (!snap.hasData || snap.hasError) {
            return LoadingScreen();
          } else {
            Quiz quiz = snap.data;
           // state._start = 10;
            return Scaffold(
              appBar: AppBar(
                title: quiz.questions.length >0 ? AnimatedProgressbar(value: state.progress):Text("Training Videos"),
                  actions: [
                    Icon(Icons.timer,size:35),
                    SizedBox(
                      width:3,
                    ),
                    Text(state._start.toString(),style: Theme.of(context).textTheme.headline3)
                  ],
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.times),
                  onPressed: () => {
                    if(state._timer!=null) state._timer.cancel(),
                    Navigator.pop(context),
                  }
                ),
                backgroundColor: Colors.purpleAccent
              ),
              body:
              PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz);
                  } else if (idx == quiz.questions.length + 1 || state._start<1 ) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  final PageController controller;
  StartPage({this.quiz, this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline),
      /*ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/covers/YoutubeIcon.png')
          ),
          //subtitle: Text('Click to play the video'), //           <-- subtitle
        title: Text("Related videos for " + quiz.description, style: Theme.of(context).textTheme.bodyText1),
        onTap: () {
            FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyAssc1bXstLd_V2f3V_P-YZLOlh2oYP9eg",
          videoUrl: quiz.video,
          autoPlay: true, //default falase
          fullScreen: true //default false
      );
         }
      ),*/
          /*Container(
              child:FlutterYoutube.playYoutubeVideoByUrl(
                  apiKey: "AIzaSyAssc1bXstLd_V2f3V_P-YZLOlh2oYP9eg",
                  videoUrl: "https://www.youtube.com/watch?v=j8ordKVH604",
                  autoPlay: false, //default falase
                  fullScreen: false //default false
              )*/
         // Expanded(child:VideoPlayerScreen(videoUrl: quiz.video)),
          //SizedBox(height: 50.0,),
          Text("Related information for " + quiz.description, style: Theme.of(context).textTheme.bodyText2),
          //SizedBox(height: 50.0,),
         // quiz.video!="" ? Expanded(child:VideoList(videoId: YoutubePlayer.convertUrlToId(quiz.video))):Expanded(child:Text("")),
          quiz.video!="" ? Expanded(child:CachedNetworkImage(
            imageUrl: quiz.video,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )):Expanded(child:Text("")),
          quiz.questions.length <=0 ? Text(""):
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: state.startTimer,
                label: Text('Start Test!'),
                icon: Icon(Icons.poll),
                color: Colors.green,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  CongratsPage({this.quiz});
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          Divider(),
          Image.asset('assets/congrats.gif'),
          Divider(),
          FlatButton.icon(
            color: Colors.green,
            icon: Icon(FontAwesomeIcons.check),
            label: Text(' Mark Complete!'),
            onPressed: () {
              _updateUserReport(quiz,state.lstCorrectItems);
              _updateExcelreport(quiz,state.lstCorrectItems);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }

  /// Database write to update report doc when complete
  Future<void> _updateUserReport(Quiz quiz,List<String> lstCorrectItems) {
    return Global.reportRef.upsert(
      ({
        'total': FieldValue.increment(1),
        'topics': {
          '${quiz.topic}': FieldValue.arrayUnion([quiz.id]),
        },
        'quizzes':{
          '${quiz.id}' : lstCorrectItems.length
        }
      }),
    );
  }

  Future<void> _updateExcelreport (Quiz quiz,List<String> lstCorrectItems) async {
   Report objreport = await  Global.reportRef.getDocument();
     ResulttoForm resulttoForm = ResulttoForm(
      objreport.name,objreport.uid,objreport.rollno,objreport.college,objreport.branch,quiz.topic,
       DateTime.now().toString(),quiz.time.toString(),quiz.id,quiz.questions.length.toString(),lstCorrectItems.length.toString()
     );
   FormController formController = FormController((String response) {
      print("Response: $response");
     if (response == FormController.STATUS_SUCCESS) {
       // Feedback is saved succesfully in Google Sheets.
      // _showSnackbar("Feedback Submitted");
       print("Feedback Submitted");
     } else {
       // Error Occurred while saving data in Google Sheets.
      // _showSnackbar("Error Occurred!");
       print("Error Occurred!");
     }
   }
   );

   //_showSnackbar("Submitting Feedback");
   //print("Submitting Feedback");

   // Submit 'feedbackForm' and save it in Google Sheets.
   formController.submitForm(resulttoForm);
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  QuestionPage({this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    state.nextPage();
                   // _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.circle,
                            size: 30),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: TextStyle(fontSize: 18, color: Colors.white54),
              ),
              FlatButton(
                color: correct ? Colors.green : Colors.red,
                child: Text(
                  correct ? 'Onward!' : 'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}




