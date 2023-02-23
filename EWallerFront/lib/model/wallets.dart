import 'dart:convert';

import 'package:http/http.dart' as http;

class Wallet{
  int? id;
  String? name;
  String? slug;
  String? balance;



  Wallet.fromJason(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    slug=json['slug'];
    balance=json['balance'];


  }

}

Future<List<Wallet>> fetchTrans() async {
  final response = await http
      .get(Uri.parse('https://walletiscae.pythonanywhere.com/api/my_api/Wallets'),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT '
      });




  if (response.statusCode == 200) {
    var getJobs = jsonDecode(response.body) as List;
    return getJobs.map((i) => Wallet.fromJason(i)).toList();

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


