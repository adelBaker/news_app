import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app2/global.dart';
import 'package:news_app2/model/api.dart';
import 'package:news_app2/view/news_layout.dart';

class LoginController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  /// Sign up information
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordSignUp = TextEditingController();



  RxBool showPassword = false.obs;
  RxBool sign_up_option = false.obs;


  submit(email_text, password_text,context){
    Api.login(email_text, password_text).then((value){
      if(value != null){
        Global.Save_login(email_text, password_text, value.first.id);
        Global.userId = int.parse(value.first.id);
        username.clear();
        password.clear();
       Get.offAll(()=>NewsLayout());
      }else{
        const snackBar = SnackBar(
          content: Text('Wrong email or password'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Wrong email or password');
      }
    });
  }

  signUp(){
    Api.signUp(name.text, email.text, passwordSignUp.text).then((value){
      if(value != null){
        Global.Save_login(email.text, passwordSignUp.text, value[0]['id_user']);
        Global.userId = int.parse(value[0]['id_user']);
        print(Global.userId);
         Get.offAll(()=>NewsLayout());
      }else{

      }
    });
  }

}