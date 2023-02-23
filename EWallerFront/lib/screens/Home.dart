// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, duplicate_ignore, non_constant_identifier_names, dead_code, unused_label

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waletayty/model/Transaction.dart';

import '../model/wallets.dart';
//import 'package:waletayty/model/Wallet.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHometState();
}

class _PageHometState extends State<PageHome> {
  var transactionHistory;
  var userdata;
  String token = '';
  late Future<List<Transaction>> futureTransaction;
  void initState() {
    super.initState();
    _loadCounter();
    futureTransaction = fetchTrans();

  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userdata  = json.decode(prefs.getString('userdata')??'');
     token = userdata['token'];
    });
  }
  Future<List<Transaction>> fetchTrans() async {
    final response = await http
        .get(Uri.parse('https://walletiscae.pythonanywhere.com/api/my_api/transactions'),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT '+token
        });




    if (response.statusCode == 200) {
      var getJobs = jsonDecode(response.body) as List;
      return getJobs.map((i) => Transaction.fromJason(i)).toList();

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
              Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 240,
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                              color: Color(0xff368983),
                              // ignore: prefer_const_constructors
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 35,
                                  left: 340,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Color.fromRGBO(250, 250, 250, 0.1),
                                      child: Icon(
                                        Icons.notification_add_outlined,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 35, left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 224, 223, 223),
                                        ),
                                      ),
                                      Text(
                                        'My Wallet',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 140,
                        left: 37,
                        child: Container(
                          height: 170,
                          width: 320,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(47, 125, 121, 0.3),
                                offset: Offset(0, 6),
                                blurRadius: 12,
                                spreadRadius: 6,
                              ),
                            ],
                            color: Color.fromARGB(255, 47, 125, 121),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Balance',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 7),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      userdata['balance'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 13,
                                          backgroundColor:
                                          Color.fromARGB(255, 85, 145, 141),
                                          child: Icon(
                                            Icons.arrow_downward,
                                            color: Colors.white,
                                            size: 19,
                                          ),
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          'Income',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 216, 216, 216),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 13,
                                          backgroundColor:
                                          Color.fromARGB(255, 85, 145, 141),
                                          child: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                            size: 19,
                                          ),
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          'outcome',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 216, 216, 216),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$ 677',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$ 68898',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                'Transactions History',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                  color: Colors.black,
                                ),
                              ),
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: (){
                                  fetchTrans();
                                },
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],

                          ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                            children: [
                              FutureBuilder<List<Transaction>>(
                                  future: fetchTrans(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: (snapshot.data as List<Transaction>).length,
                                        itemBuilder: (context, index) {
                                          var oneJob = (snapshot.data as List<Transaction>)[index];
                                          if (snapshot.hasData) {
                                            return jobComponent( trans: oneJob);
                                          }
                                          else if (snapshot.hasError) {
                                            return Center(child: Text("${snapshot.error}"));
                                          }
                                          return Center(
                                              child: CircularProgressIndicator(color: Colors.white)
                                          );
                                        }, separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox();
                                      },
                                      );
                                    }
                                    else{
                                      return Container();
                                    }
                                  }
                              )
                   ])),
                        )




                        ],
                      )))
            ])));

    // return Stack(

    // );

    // ignore: dead_code
    // return Scaffold (
    //   body: SafeArea(
    // ignore: dead_code

    //   ),
    // );
  }

  jobComponent({required Transaction trans}) {
    return GestureDetector(
      onTap: () async {


      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ]
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                      children: [
                        // Container(
                        //     width: 60,
                        //     height: 60,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(20),
                        //       child: Image.network(job.image.toString()),
                        //     )
                        // ),
                        // SizedBox(width: 10),
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(trans.comment.toString(), style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                                SizedBox(height: 5,),
                                Text(trans.date.toString(), style: TextStyle(color: Colors.grey[500])),
                              ]
                          ),
                        )
                      ]
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   job.isMyFav = !job.isMyFav;
                    // });
                  },
                  child: AnimatedContainer(
                      height: 35,
                      padding: EdgeInsets.all(5),
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade100 )
                      ),
                      child: Center(
                          child: Icon(Icons.favorite_outline, color: Color.fromARGB(255, 47, 125, 121),)
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade200
                          ),
                          child: Expanded(
                            child: Text(

                              trans.transaction_type.toString(),
                              style: TextStyle(
                                  color: Colors.black
                              ),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}