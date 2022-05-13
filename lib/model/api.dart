import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app2/global.dart';
import 'package:news_app2/model/article.dart';
import 'package:news_app2/model/favoraite.dart';
import 'package:news_app2/model/user.dart';



class Api {

  ///  emulator
  // static String localHostUrl = 'http://10.0.2.2:8080';
  /// mobile Device
  static String localHostUrl = 'http://192.168.1.4:8080';

  static Future login(user_email, user_password) async {

    var url = '$localHostUrl/news_backend/sendData.php';
      final response = await http.post(Uri.parse(url), body: {
        'action' :  'getUserInformation',
        'email' : user_email,
        'password': user_password,
      });
      var user = <User>[];
      if (response.statusCode == 200) {
        if(response.body.isEmpty){
          return null;
        }else{
          print('Successfully');
          var userListJson = json.decode(response.body);
          for (var userJson in userListJson) {
            user.add(User.fromJson(userJson));
          }
          return user;
        }
    }else{
        return null;
    }
  }

    static Future signUp(name, email, passwordSignUp)async{
      var url = '$localHostUrl/news_backend/sendData.php';
      final response = await http.post(Uri.parse(url), body: {
        'action' :  'signUp',
        'name' : name,
        'email' : email,
        'password': passwordSignUp,
      });

      if (response.statusCode == 200) {
        var userId = json.decode(response.body);
      return userId;
    }
      else {
        return false;
      }

    }

  static Future<List<Article>> getSports() async {

    http.Response response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=ab73f690c8be4f86a9a4428fabbb31e8'));
    
    if (response.statusCode == 200) {

      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<Article> sportList = body.map((dynamic item)=> Article.fromJson(item)).toList();

      return sportList;

    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future<List<Article>> getBusiness() async {

    http.Response response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ab73f690c8be4f86a9a4428fabbb31e8'));

    if (response.statusCode == 200) {

      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<Article> businessList = body.map((dynamic item)=> Article.fromJson(item)).toList();

      return businessList;

    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future<List<Article>> getScience() async {

    http.Response response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=ab73f690c8be4f86a9a4428fabbb31e8'));

    if (response.statusCode == 200) {

      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<Article> scienceList = body.map((dynamic item)=> Article.fromJson(item)).toList();

      return scienceList;

    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future increaseSportCounter(String id) async {
    var request = http.MultipartRequest('POST', Uri.parse('$localHostUrl/news_backend/sendData.php'));
    request.fields.addAll({
      'action': 'increaseSportCounter',
      'id_user': id
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Successfully');
      return true;
    }
    else {
      print('Field');
      return false;
    }

  }

  static Future increaseBusinessCounter(String id) async {
    var request = http.MultipartRequest('POST', Uri.parse('$localHostUrl/news_backend/sendData.php'));
    request.fields.addAll({
      'action': 'increaseBusniessCounter',
      'id_user': id
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Successfully');
      return true;
    }
    else {
      print('Field');
      return false;
    }

  }

  static Future increaseScienceCounter(String id) async {
    var request = http.MultipartRequest('POST', Uri.parse('$localHostUrl/news_backend/sendData.php'));
    request.fields.addAll({
      'action': 'increaseScienceCounter',
      'id_user': id
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Successfully');
      return true;
    }
    else {
      print('Field');
      return false;
    }

  }

  static Future<Favorite> getFavoriteCategore(String id) async {
    var request = http.MultipartRequest('POST', Uri.parse('$localHostUrl/news_backend/sendData.php'));
    request.fields.addAll({
      'action': 'discoverFavorite',
      'id_user': id
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsondata = await response.stream.bytesToString();
      var data = jsonDecode(jsondata) as List;
      return Favorite.fromMap(data[0]);
    }
    else {
      print(response.reasonPhrase);
      return Favorite(sportCounter: '-1', scienceCounter: '-1', buisnessCounter: '-1');
    }
  }
}