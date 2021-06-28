

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lcp/rud.dart';
import 'package:lcp/start.dart';
import 'package:lcp/stats.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  QuerySnapshot statsQuery;
  String scorerPassword;
  BannerAd bannerAd;

  @override
  void initState(){
    CrudMethods().getData("AllStats").then((result){
      setState(() {
        statsQuery=result;
      });
    });
    bannerAd=BannerAd(
      adUnitId: "ca-app-pub-5997536979820908/4314134046",
      size: AdSize.banner,
    );
    loadBannerAd();
    super.initState();
  }

  @override
  void dispose(){
    bannerAd?.dispose();
    super.dispose();
  }
  initAdMob(){
    return FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5997536979820908~8253379057");
  }

  loadBannerAd(){
    bannerAd..load()..show();
  }

  scorerDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Verify Scorer.."),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter Scorer Password:",
            ),
            autofocus: false,
            obscureText: true,
            onChanged: (val){
              setState(() {
                scorerPassword=val;
              });
            },
          ),
          actions: <Widget>[
            RaisedButton(
              elevation: 5.0,
              color: Colors.deepOrange,
              child: Text("Verify"),
              onPressed: (){
                if(scorerPassword!="ScorerHero"){
                  Navigator.pop(context);
                }
                else{
                  setState(() {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>Start(),
                    ));
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lacchil Championship League"),
        ),
        body: Builder(
          builder: (context)=>Container(
            color: Colors.limeAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        elevation: 5.0,
                        child: Text("Start",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        onPressed: (){
                          scorerDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: 200.0,
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.deepOrange,
                        child: Text("Stats",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>Stats(statsQuery),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

