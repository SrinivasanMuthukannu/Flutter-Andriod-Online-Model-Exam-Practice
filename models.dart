//// Embedded Maps

class Option {
  String value;
  String detail;
  bool correct;

  Option({ this.correct, this.value, this.detail });
  Option.fromMap(Map data) {
    value = data['value'];
    detail = data['detail'] ?? '';
    correct = data['correct'];
  }
}


class Question {
  String text;
  List<Option> options;
  Question({ this.options, this.text });

  Question.fromMap(Map data) {
    text = data['text'] ?? '';
    options = (data['options'] as List ?? []).map((v) => Option.fromMap(v)).toList();
  }
}

///// Database Collections

class Quiz { 
  String id;
  String title;
  String description;
  String video;
  String topic;
  int time;
  List<Question> questions;

  Quiz({ this.title, this.questions, this.video, this.description, this.id, this.topic,this.time });

  factory Quiz.fromMap(Map data) {
    return Quiz(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      topic: data['topic'] ?? '',
      description: data['description'] ?? '',
      video: data['video'] ?? '',
        time: data['time'] ?? 0,
      questions: (data['questions'] as List ?? []).map((v) => Question.fromMap(v)).toList()
    );
  }
  
}


class Topic {
  final String id;
  final String title;
  final  String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({ this.id, this.title, this.description, this.img, this.quizzes });

  factory Topic.fromMap(Map data) {
    return Topic(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      quizzes:  (data['quizzes'] as List ?? []).map((v) => Quiz.fromMap(v)).toList(), //data['quizzes'],
    );
  }

}


class Report {
  String uid;
  int total;
  dynamic topics;
  dynamic quizzes;
  String name;
  String rollno;
  String college;
  String branch;
  bool isAdmin;

  Report({ this.uid, this.topics, this.total,this.quizzes,this.name,this.rollno,this.college,this.branch,this.isAdmin });

  factory Report.fromMap(Map data) {
    return Report(
      uid: data['uid'],
      total: data['total'] ?? 0,
      topics: data['topics'] ?? {},
      quizzes: data['quizzes'] ?? {},
      name: data['name'] ?? '',
      rollno: data['rollno'] ?? '',
      branch: data['branch'] ?? '',
      college: data['college'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }

}

class ResulttoForm {
  String name;
  String loginid;
  String rollno;
  String collegename;
  String department;
  String testName;
  String testdate;
  String testduration;
  String subcategory;
  String noofquestions;
  String correct;

  ResulttoForm(this.name, this.loginid, this.rollno,this.collegename,this.department,
      this.testName,this.testdate,this.testduration,this.subcategory,this.noofquestions,this.correct
      );

  // Method to make GET parameters.
  String toParams() =>
      "?name=$name&loginid=$loginid&rollno=$rollno&collegename=$collegename&department=$department&testName=$testName&testdate=$testdate&testduration=$testduration&subcategory=$subcategory&noofquestions=$noofquestions&correct=$correct";
}

class Trainings {
  String id;
  List<Video> videos;

  Trainings({ this.id,this.videos});

  factory Trainings.fromMap(Map data) {
    return Trainings(
        id: data['id'] ?? '',
        videos: (data['videos'] as List ?? []).map((v) => Video.fromMap(v)).toList()
    );
  }

}

class Video
{
  String videoId;
  Video({ this.videoId });

  Video.fromMap(Map data) {
    videoId = data['videoId'] ?? '';
  }
}