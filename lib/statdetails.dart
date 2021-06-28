import 'package:flutter/material.dart';

class MatchStats extends StatefulWidget {

  String firstBat,secondBat;
  int matchNo,firstRuns,secondRuns,firstBalls,secondBalls,firstExtra,secondExtra;
  List<String> firstHistory,secondHistory;

  MatchStats(this.matchNo,this.firstBat,this.secondBat,this.firstRuns,this.secondRuns,this.firstBalls,this.secondBalls,this.firstExtra,this.secondExtra,this.firstHistory,this.secondHistory);

  @override
  _MatchStatsState createState() => _MatchStatsState(matchNo,firstBat,secondBat,firstRuns,secondRuns,firstBalls,secondBalls,firstExtra,secondExtra,firstHistory,secondHistory);
}

class _MatchStatsState extends State<MatchStats> {

  String firstBat,secondBat,i;
  int matchNo,firstRuns,secondRuns,firstBalls,secondBalls,firstExtra,secondExtra,rj1=0,rj2=0;
  List<String> firstHistory,secondHistory,firstHistory1=List(),firstHistory2=List(),firstHistory3=List(),secondHistory1=List(),secondHistory2=List(),secondHistory3=List();

  _MatchStatsState(this.matchNo,this.firstBat,this.secondBat,this.firstRuns,this.secondRuns,this.firstBalls,this.secondBalls,this.firstExtra,this.secondExtra,this.firstHistory,this.secondHistory){
    if(firstHistory.length>20){
      if(firstHistory.length>40){
        int i;
        for(i=0;i<20;i++){
          firstHistory1.add(firstHistory[i]);
        }
        for(i=20;i<40;i++){
          firstHistory2.add(firstHistory[i]);
        }
        for(i=40;i<firstHistory.length;i++){
          firstHistory3.add(firstHistory[i]);
        }
      }
      else{
        int i,j=0;
        for(i=0;i<20;i++){
          firstHistory1.add(firstHistory[i]);
        }
        for(i=20;i<firstHistory.length;i++){
          firstHistory2.add(firstHistory[i]);
        }
      }
    }
    else{
      for(int i=0;i<firstHistory.length;i++){
        firstHistory1.add(firstHistory[i]);
      }
    }
    if(secondHistory.length>20){
      if(secondHistory.length>40){
        int i,j=0,k=0;
        for(i=0;i<20;i++){
          secondHistory1.add(secondHistory[i]);
        }
        for(i=20;i<40;i++){
          secondHistory2.add(secondHistory[i]);
        }
        for(i=40;i<secondHistory.length;i++){
          secondHistory3.add(secondHistory[i]);
        }
      }
      else{
        int i,j=0;
        for(i=0;i<20;i++){
          secondHistory1.add(secondHistory[i]);
        }
        for(i=20;i<secondHistory.length;i++){
          secondHistory2.add(secondHistory[i]);
        }
      }
    }
    else{
      for(int i=0;i<secondHistory.length;i++){
        secondHistory1.add(secondHistory[i]);
      }
    }
  }

  strikeRate(int bRuns,int bBalls,bExtra){
    double sRate=((bRuns-bExtra)/bBalls)*100;
    return sRate.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match "+matchNo.toString()+" Stats"),
      ),
      body: Container(
        color: Colors.limeAccent,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10.0,
                color: Colors.pinkAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 200.0,
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(firstBat,style: TextStyle(color: Colors.deepPurple[700],fontSize: 25.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 20.0,),
                            Row(
                              children: <Widget>[
                                Text("Score : "+firstRuns.toString()+" ("+firstBalls.toString()+")",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(width: 20.0,),
                                Text("Strike Rate : "+strikeRate(firstRuns,firstBalls,firstExtra),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              children: <Widget>[
                                Text("Extras : "+firstExtra.toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              children: [
                                Text("Run History : ",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                for(i in firstHistory1)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            firstHistory.length>20?Row(
                              children: <Widget>[
                                for(i in firstHistory2)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ):SizedBox(),
                            firstHistory.length>40?Row(
                              children: <Widget>[
                                for(i in firstHistory3)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ):SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10.0,
                color: Colors.pinkAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 200.0,
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(secondBat,style: TextStyle(color: Colors.deepPurple[700],fontSize: 25.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 20.0,),
                            Row(
                              children: <Widget>[
                                Text("Score : "+secondRuns.toString()+" ("+secondBalls.toString()+")",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(width: 20.0,),
                                Text("Strike Rate : "+strikeRate(secondRuns,secondBalls,secondExtra),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              children: <Widget>[
                                Text("Extras : "+secondExtra.toString(),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                             Row(
                              children: <Widget>[
                                Text("Run History : ",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                             ),
                            Row(
                              children: <Widget>[
                                for(i in secondHistory1)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            secondHistory.length>20?Row(
                              children: <Widget>[
                                for(i in secondHistory2)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ):SizedBox(),
                            secondHistory.length>40?Row(
                              children: <Widget>[
                                for(i in secondHistory3)Text(i+",",style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ):SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
