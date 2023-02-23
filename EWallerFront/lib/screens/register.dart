import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:waletayty/screens/Login.dart';
import '../widgets/buttonnavigation.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _passwordController = TextEditingController();
  final _NumteleController = TextEditingController();

  void registerUser(
      String username,
      String nom,
      String prenom,
      String password,
      String Numtele
      ) async {
    try{
      print(username+" "+nom+" "+prenom+" "+password+" "+Numtele);
      Response response = await post(
        Uri.parse('https://walletiscae.pythonanywhere.com/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'nom': nom,
          'prenom': prenom,
          'password': password,
          'Numtele' : Numtele
        }),
      );
      if(response.statusCode == 200){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => LoginPage()));
        Fluttertoast.showToast(
          msg: "Bienvenue, connecion faites avec succes",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 47, 125, 121),
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }else{
        Fluttertoast.showToast(
          msg: "Erreur lors de inscription",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch(e){
      print(e.toString());
    }
  }

  int _currentStep = 0;
  TextEditingController username = new TextEditingController();
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController Numtele = new TextEditingController();





      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Register')),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(labelText: 'nom'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your nom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prenomController,
                    decoration: InputDecoration(labelText: 'prenom'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your prenom';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _NumteleController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Numtele'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Numtele';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  MaterialButton(
                    child: Text('Register'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        registerUser(_usernameController.text,_nomController.text, _prenomController.text, _passwordController.text, _NumteleController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }


    }
