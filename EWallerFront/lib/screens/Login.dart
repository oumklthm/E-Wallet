// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:waletayty/screens/register.dart';
import 'package:http/http.dart' as http;
import '../widgets/buttonnavigation.dart';
import 'Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // late String username;
  // late String password;
  late final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();



  void loginUser(String username, String password) async {
  print("hello");
  await http.post(
  Uri.parse('https://walletiscae.pythonanywhere.com/login/'),
  headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String, String>{
  'username' : username,
  'password' : password
  }),
  ).then((request) async {
  print("hello 2 ");
  if (request.statusCode == 200) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userdata', request.body);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Bottom()));
    Fluttertoast.showToast(
      msg: "Bienvenue, connecion faites avec succes",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 47, 125, 121),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  //jwtResponse = jwtResponseFromJson(request.body);
  } else if (request.statusCode != 200){
    Fluttertoast.showToast(
      msg: "verifier les donnees",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );

  print(request.body.toString()+"response code");
  print('Error !');
  }
  else{
    Fluttertoast.showToast(
      msg: "Erreur",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
  });
  print("fin");

  // print("mav6an l chi");
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _usernameController.text = value!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _passwordController.text = value!;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Call authentication API with email and password
                      // If authentication succeeds, navigate to main app screen
                      // Otherwise, show error message
                      print("my username is : "+_usernameController.text);
                      print("my password is : "+_passwordController.text);

                      loginUser(_usernameController.text, _passwordController.text);
                    }
                  },


                  child: Text('Login')

              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color.fromARGB(255, 85, 145, 141),
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

