import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'services/services.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL for Syasan.
  static const String URL = "https://script.google.com/macros/s/AKfycbz2iTwwbke5B7AxSOc93kIaKub6SzeIh8tU--x6aJDLvl8Dbe4/exec";
  static const String DataSyncURL ="https://script.google.com/macros/s/AKfycbwH6aCBSQblqPhDUhWzpXYOJt-S1CMte7Ghtwjc1VWE5zAG0sk/exec";

  // Google App Script Web URL for Golearn.
  //static const String URL = "https://script.google.com/macros/s/AKfycbw_dZ0EpCnnlgjpFQYorBPQyRggkpNRNRGVwh-gEPV7a-6jNQaO/exec";
  //static const String DataSyncURL ="https://script.google.com/macros/s/AKfycbzTvW4a3V4H8GTfQmWTlr8CL4nR9W7ZLbT7Fu_z6p5T-d9ttb0Z/exec";


  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  FormController(this.callback);

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(ResulttoForm excelformdata) async {
    try {
      await http.get(
          URL + excelformdata.toParams()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }

  // Bulk upload of Data from google sheets to Firbase
  void submitDataSync() async {
    try {
      await http.get(
          DataSyncURL+"?name=upload"
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}