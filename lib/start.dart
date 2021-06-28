import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lcp/rud.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Start extends StatefulWidget {

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  bool batWho=false,targetSet=false,matchNoLoaded=false,interAdReady=false;
  String batsman,outMethod1="NotOut",outMethod2="NotOut";
  int runScored=0,ballsFaced=0,extraScored=0,targetScored,targetFaced,targetExtra,matchNo;
  List<String> runHistory1=List();
  List<String> runHistory2=List();
  QuerySnapshot statsQuery;
  InterstitialAd interAd;

  @override
  void initState(){
    CrudMethods().getData("AllStats").then((results){
      setState(() {
        statsQuery=results;
        matchNo=statsQuery.documents.length+1;
        matchNoLoaded=true;
      });
    });
    super.initState();
  }

  loadInterAd(){
    interAd.load();
  }

  interAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        interAdReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        interAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      default:
    }
  }


  undoPrev(){
    if(targetSet==false){
      print(runHistory1[runHistory1.length-1]);
      if(runHistory1[runHistory1.length-1]=="4"){
        setState(() {
          runScored-=4;
          ballsFaced-=1;
          runHistory1.removeLast();
        });
      }
      else if(runHistory1[runHistory1.length-1]=="Ex"){
        setState(() {
          runScored-=1;
          extraScored-=1;
          runHistory1.removeLast();
        });
      }
      else if(runHistory1[runHistory1.length-1]=="*"){
        setState(() {
          ballsFaced-=1;
          runHistory1.removeLast();
        });
      }
    }
    else{
      if(runHistory2[runHistory2.length-1]=="4"){
        setState(() {
          runScored-=4;
          ballsFaced-=1;
          runHistory1.removeLast();
        });
      }
      else if(runHistory2[runHistory2.length-1]=="Ex"){
        setState(() {
          runScored-=1;
          extraScored-=1;
          runHistory2.removeLast();
        });
      }
      else if(runHistory2[runHistory2.length-1]=="*"){
        setState(() {
          ballsFaced-=1;
          runHistory2.removeLast();
        });
      }
    }
  }

  winDone(){
    if(targetSet==true){
      if(runScored>targetScored){
        wonDialog(context, batsman);
      }
    }
  }

  wonDialog(BuildContext context,String winner){
    String resultState;
    if(targetScored==runScored){
      resultState="Whoops...!!\nMatch Tied...";
    }
    else{
      resultState="Congratulations!!\n"+winner+" Won the Match...";
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Result Declared.."),
          content: Text(resultState,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
          actions: <Widget>[
            RaisedButton(
              elevation: 5.0,
              color: Colors.deepOrange,
              child: Text("Finish"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Map<String,dynamic> statDetail={'MatchNo':matchNo,'FirstBat':batsman=="Pawan"?"Dhanush":"Pawan",'FirstRuns':targetScored,'FirstBalls':targetFaced,'FirstExtra':targetExtra,'FirstHistory':runHistory1,'SecondBat':batsman,'SecondRuns':runScored,'SecondBalls':ballsFaced,'SecondExtra':extraScored,'SecondHistory':runHistory2,'FirstOutMethod':outMethod1,'SecondOutMethod':outMethod2};
                CrudMethods().addData(statDetail, "AllStats");
              },
            ),
          ],
        );
      }
    );
  }

  batDone(){
    if(targetSet){
      if(ballsFaced%6==1){
        interAd=InterstitialAd(
          adUnitId: "ca-app-pub-5997536979820908/7811360079",
          listener: interAdEvent,
        );
        loadInterAd();
      }
      if(ballsFaced%6==0){
        if(interAdReady){
          interAd.show();
          setState(() {
            interAdReady=false;
          });
        }
      }
      if(ballsFaced==60){
        if(runScored<targetScored){
          wonDialog(context,batsman=="Pawan"?"Dhanush":"Pawan");
        }
        if(runScored==targetScored){
          wonDialog(context, "Pawan");
        }
      }
    }
    else{
      if(ballsFaced%6==1){
        interAd=InterstitialAd(
          adUnitId: "ca-app-pub-5997536979820908/7811360079",
          listener: interAdEvent,
        );
        loadInterAd();
      }
      if(ballsFaced%6==0){
        if(interAdReady){
          interAd.show();
          setState(() {
            interAdReady=false;
          });
        }
      }
      if(ballsFaced==60){
        setState(() {
          targetSet=true;
          targetScored=runScored;
          targetFaced=ballsFaced;
          targetExtra=extraScored;
          runScored=0;
          ballsFaced=0;
          extraScored=0;
          batsman=="Pawan"?batsman="Dhanush":batsman="Pawan";
        });
      }
    }
  }

  outMethod(BuildContext context,String outMet){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Out Method.."),
          content: SizedBox(
            height: 100.0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.deepOrange,
                      elevation: 5.0,
                      child: Text("Bowled"),
                      onPressed: (){
                        setState(() {
                          if(outMet=="out1"){
                            outMethod1="Bowled";
                            Navigator.pop(context);
                          }
                          else{
                            outMethod2="Bowled";
                            Navigator.pop(context);
                            wonDialog(context, batsman=="Pawan"?"Dhanush":"Pawan");
                          }
                        });
                      },
                    ),
                    SizedBox(width: 20.0,),
                    RaisedButton(
                      color: Colors.deepOrange,
                      elevation: 5.0,
                      child: Text("Caught"),
                      onPressed: (){
                        setState(() {
                          if(outMet=="out1"){
                            outMethod1="Caught";
                            Navigator.pop(context);
                          }
                          else{
                            outMethod2="Caught";
                            Navigator.pop(context);
                            wonDialog(context, batsman=="Pawan"?"Dhanush":"Pawan");
                          }
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.deepOrange,
                      elevation: 5.0,
                      child: Text("HitWicket"),
                      onPressed: (){
                        setState(() {
                          if(outMet=="out1"){
                            outMethod1="HitWicket";
                            Navigator.pop(context);
                          }
                          else{
                            outMethod2="HitWicket";
                            Navigator.pop(context);
                            wonDialog(context, batsman=="Pawan"?"Dhanush":"Pawan");
                          }
                        });
                      },
                    ),
                    SizedBox(width: 20.0,),
                    RaisedButton(
                      color: Colors.deepOrange,
                      elevation: 5.0,
                      child: Text("6Out"),
                      onPressed: (){
                        setState(() {
                          if(outMet=="out1"){
                            outMethod1="6Out";
                            Navigator.pop(context);
                          }
                          else{
                            outMethod2="6Out";
                            Navigator.pop(context);
                            wonDialog(context, batsman=="Pawan"?"Dhanush":"Pawan");
                          }
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              elevation: 5.0,
              color: Colors.red,
              child: Text("Cancel"),
              onPressed: (){
                setState(() {
                  if(targetSet){
                    if(runHistory2.length==0){
                      targetSet=false;
                    }
                    else{
                      runHistory2.removeLast();
                      ballsFaced-=1;
                      Navigator.pop(context);
                    }
                  }
                  if(targetSet==false){
                    runHistory1.removeLast();
                    runScored=targetScored;
                    ballsFaced=targetFaced;
                    extraScored=targetExtra;
                    ballsFaced-=1;
                    batsman=="Pawan"?batsman="Dhanush":batsman="Pawan";
                    Navigator.pop(context);
                  }
                });
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return matchNoLoaded?Scaffold(
      appBar: AppBar(
        title: Text("LCL Match "+matchNo.toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: (){
              undoPrev();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.limeAccent,
        child: batWho?Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Text(batsman+" :",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 120.0,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 160.0,),
                  Text(runScored.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.0),),
                  Text("   ("+ballsFaced.toString()+")   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),)
                ],
              ),
            ),
            Text("Extras: "+extraScored.toString(),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            targetSet?Text((batsman=="Pawan"?"Dhanush":"Pawan")+" : "+targetScored.toString()+" ("+targetFaced.toString()+") ",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),):SizedBox(),
            SizedBox(height: 20.0,),
            Text("Run History:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,),),
            SizedBox(height: 20.0,),
            SizedBox(
              height: 70.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: runHistory1.length,
                  itemBuilder: (context,i){
                    return Text(runHistory1[i]+",",style: TextStyle(color: Colors.purple,fontSize: 20.0,fontWeight: FontWeight.bold),);
                  }),
            ),
            SizedBox(
              height: 70.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: runHistory2.length,
                  itemBuilder: (context,i){
                    return Text(runHistory2[i]+",",style: TextStyle(color: Colors.purple,fontSize: 20.0,fontWeight: FontWeight.bold),);
                  }),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 60.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        setState(() {
                          targetSet?runHistory2.add("4"):runHistory1.add("4");
                          runScored+=4;
                          ballsFaced++;
                          batDone();
                          winDone();
                        });
                      },
                      child: Text("4",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(width: 50.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        setState(() {
                          runScored+=1;
                          winDone();
                          targetSet?runHistory2.add("Ex"):runHistory1.add("Ex");
                          extraScored+=1;
                        });
                      },
                      child: Text("Extra",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                SizedBox(width: 60.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        setState(() {
                          ballsFaced+=1;
                          targetSet?runHistory2.add("*"):runHistory1.add("*");
                          batDone();
                        });
                      },
                      child: Text("Dot",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(width: 50.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: (){
                        setState(() {
                          if(targetSet) {
                            ballsFaced+=1;
                            runHistory2.add("Out");
                            outMethod(context,"out2");
                          }
                          else{
                            ballsFaced+=1;
                            targetSet=true;
                            runHistory1.add("Out");
                            outMethod(context,"out1");
                            targetScored=runScored;
                            targetFaced=ballsFaced;
                            targetExtra=extraScored;
                            runScored=0;
                            ballsFaced=0;
                            extraScored=0;
                            batsman=="Pawan"?batsman="Dhanush":batsman="Pawan";
                          }
                        });
                      },
                      child: Text("Out",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            ),
          ],
        ):Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text("Who is Batting First?",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.deepOrange,
                  child: Text("Pawan"),
                  onPressed: (){
                    setState(() {
                      batWho=true;
                      batsman="Pawan";
                    });
                  },
                ),
                SizedBox(width: 40.0,),
                RaisedButton(
                  color: Colors.deepOrange,
                  child: Text("Dhanush"),
                  onPressed: (){
                    setState(() {
                      batWho=true;
                      batsman="Dhanush";
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ):Container(
      color: Colors.limeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Loading...",style: TextStyle(fontSize: 18.0),),
          ),
        ],
      ),
    );
  }
}
