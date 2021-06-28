import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lcp/statdetails.dart';
import 'package:lcp/totalstatdetails.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Stats extends StatefulWidget {

  QuerySnapshot statsQuery;

  Stats(this.statsQuery);

  @override
  _StatsState createState() => _StatsState(statsQuery);
}

class _StatsState extends State<Stats> {

  QuerySnapshot statsQuery;
  List<List<String>> firstHistory=List();
  List<List<String>> secondHistory=List();
  List<int> matchNoIndexSort=List();
  InterstitialAd interAd;
  bool interAdReady=false;

  _StatsState(this.statsQuery) {
    interAd=InterstitialAd(
      adUnitId: "ca-app-pub-5997536979820908/7811360079",
      listener: interAdEvent,
    );
    for (int i = 0; i < statsQuery.documents.length; i++) {
        firstHistory.add(List.from(statsQuery.documents[i].data['FirstHistory']));
        secondHistory.add(List.from(statsQuery.documents[i].data['SecondHistory']));
    }
    for(int i=0;i<statsQuery.documents.length;i++){
      for(int j=0;j<statsQuery.documents.length;j++){
        if(statsQuery.documents[j].data['MatchNo']==i+1){
          matchNoIndexSort.add(j);
          break;
        }
      }
    }
    loadInterAd();
  }

  loadInterAd(){
    interAd.load();
  }

  interAdEvent(MobileAdEvent event){
    switch(event){
      case MobileAdEvent.loaded:
        interAdReady=true;
        break;
      case MobileAdEvent.failedToLoad:
        interAdReady=false;
        print("Failed to Load an Interstitial Ad");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LCL Statistics"),
      ),
      body: Container(
        color: Colors.limeAccent,
        child: ListView.builder(
          itemCount: statsQuery.documents.length+1,
            itemBuilder: (context,i){
              interAd.show();
             if(i==0){
               return GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context)=>TotalStats(statsQuery),
                   ));
                 },
                 child: Card(
                   color: Colors.pinkAccent[400],
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Text("Total Stats",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),textAlign: TextAlign.center,),
                   ),
                 ),
               );
             }
             else{
               return GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context)=>MatchStats(statsQuery.documents[matchNoIndexSort[i-1]].data['MatchNo'], statsQuery.documents[matchNoIndexSort[i-1]].data['FirstBat'], statsQuery.documents[matchNoIndexSort[i-1]].data['SecondBat'], statsQuery.documents[matchNoIndexSort[i-1]].data['FirstRuns'], statsQuery.documents[matchNoIndexSort[i-1]].data['SecondRuns'], statsQuery.documents[matchNoIndexSort[i-1]].data['FirstBalls'], statsQuery.documents[matchNoIndexSort[i-1]].data['SecondBalls'], statsQuery.documents[matchNoIndexSort[i-1]].data['FirstExtra'], statsQuery.documents[matchNoIndexSort[i-1]].data['SecondExtra'], firstHistory[matchNoIndexSort[i-1]],secondHistory[matchNoIndexSort[i-1]]),
                   ));
                 },
                 child: Card(
                   color: Colors.deepOrange,
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Text("Match "+i.toString()+" Stats",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),textAlign: TextAlign.center,),
                   ),
                 ),
               );
             }
            },
        ),
      ),
    );
  }
}
