import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app2/controller/login_controller.dart';

class Login extends StatelessWidget {

  final formGlobalKey = GlobalKey<FormState>();
  final formGlobalKey1 = GlobalKey<FormState>();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                !loginController.sign_up_option.value ?
                Form(
                  key: formGlobalKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            controller: loginController.username,
                            validator: (email) {
                              if (email!.isEmpty) {
                                return 'user name cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                              Icon(Icons.person, color: Theme.of(context).primaryColor),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor)
                              ),
                              labelStyle: TextStyle(fontSize: 16),
                              labelText: 'username',
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(fontSize: 16),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 90,
                          child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              obscureText: !loginController.showPassword.value ? true : false,
                              obscuringCharacter: '*',
                              controller: loginController.password,
                              validator: (pass) {
                                if(pass!.isEmpty){
                                  return 'Password is Empty';
                                }
                                else if (pass.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                prefixIcon:
                                Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                                suffixIcon: !loginController.showPassword.value
                                    ? GestureDetector(
                                    onTap: (){
                                      loginController.showPassword.value = !loginController.showPassword.value;
                                    },
                                    child: Icon(Icons.visibility_outlined, color: Theme.of(context).primaryColor))
                                    : GestureDetector(
                                  onTap: (){
                                    loginController.showPassword.value = !loginController.showPassword.value;

                                  },
                                  child:  Icon(Icons.visibility_off_outlined, color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                                labelStyle: TextStyle(fontSize: 16),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.visiblePassword),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async {
                              if(formGlobalKey.currentState!.validate()){
                                loginController.submit(loginController.username.text, loginController.password.text,context);
                              }else{
                                print('false');
                              }
                            },
                            child:  Text(
                              'Login',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : Center(),
                !loginController.sign_up_option.value ?
                GestureDetector(
                  onTap: (){
                    loginController.sign_up_option.value = !loginController.sign_up_option.value;
                  },
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AnimatedSwitcher(
                        duration: const  Duration(milliseconds: 500),
                        child: !loginController.sign_up_option.value ?
                        Text('Sign up',style: Theme.of(context).textTheme.bodyText2,)
                            : Text('Return to login',style: Theme.of(context).textTheme.bodyText2),
                      )
                  ),
                ) : Center(),
                loginController.sign_up_option.value ?
                Form(
                  key: formGlobalKey1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            controller: loginController.name,
                            validator: (name) {
                              if (name!.isEmpty) {
                                return 'user name cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                              prefixIcon:
                              Icon(Icons.person, color: Theme.of(context).primaryColor),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color:Theme.of(context).dividerColor)
                              ),
                              labelStyle: TextStyle(fontSize: 16),
                              labelText: 'username',
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(fontSize: 16),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 90,
                          child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              controller: loginController.email,
                              validator: (email) {
                                if(email!.isEmpty){
                                  return 'Email is Empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                prefixIcon:
                                Icon(Icons.email, color: Theme.of(context).primaryColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                                labelStyle: TextStyle(fontSize: 16),
                                labelText: 'Eamil',
                                hintText: 'Enter your Email',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.emailAddress
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 90,
                          child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              obscureText: !loginController.showPassword.value ? true : false,
                              obscuringCharacter: '*',
                              controller: loginController.passwordSignUp,
                              validator: (pass) {
                                if(pass!.isEmpty){
                                  return 'Password is Empty';
                                }
                                else if (pass.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                prefixIcon:
                                Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                                suffixIcon: !loginController.showPassword.value
                                    ? GestureDetector(
                                    onTap: (){
                                      loginController.showPassword.value = !loginController.showPassword.value;
                                    },
                                    child: Icon(Icons.visibility_outlined, color: Theme.of(context).primaryColor))
                                    : GestureDetector(
                                  onTap: (){
                                    loginController.showPassword.value = !loginController.showPassword.value;

                                  },
                                  child:  Icon(Icons.visibility_off_outlined, color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                                labelStyle: TextStyle(fontSize: 16),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.visiblePassword),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async {
                              if(formGlobalKey1.currentState!.validate()){
                                loginController.signUp();
                                // loginController.submit(loginController.username.text, loginController.password.text);
                              }else{
                                print('false');
                              }
                            },
                            child:  Text(
                              'Sign Up',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : Center(),
                loginController.sign_up_option.value ?
                GestureDetector(
                  onTap: (){
                    loginController.sign_up_option.value = !loginController.sign_up_option.value;
                  },
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AnimatedSwitcher(
                        duration: const  Duration(milliseconds: 500),
                        child: !loginController.sign_up_option.value ?
                        Text('Sign up',style: Theme.of(context).textTheme.bodyText2,)
                            : Text('Return to login',style: Theme.of(context).textTheme.bodyText2),
                      )
                  ),
                ) :Center(),

              ],
            ),
          ),
        ),
      );
    });
  }


}
