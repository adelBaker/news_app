

import 'package:shared_preferences/shared_preferences.dart';

class Global{

  static int userId = -1;
  static String userEmail = "";
  static String userPassword = "";

  static Load_login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("email") ?? "non";
    userPassword = prefs.getString("pass")??"non";
    userId = prefs.getInt("id") ?? -1;
  }

  static Save_login(email, password,user_id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("pass", password);
    prefs.setString("id", user_id);
  }

  static logout() async {
    Global.userId = -1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("pass");
    prefs.remove("id");


  }

}