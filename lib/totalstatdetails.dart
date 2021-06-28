import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalStats extends StatefulWidget {

  QuerySnapshot statsQuery;

  TotalStats(this.statsQuery);

  @override
  _TotalStatsState createState() => _TotalStatsState(statsQuery);
}

class _TotalStatsState extends State<TotalStats> {

  QuerySnapshot statsQuery;
  int pRuns=0,dRuns=0,pBalls=0,dBalls=0,pExtra=0,dExtra=0,pFifty=0,dFifty=0,pCentury=0,dCentury=0,matches=0,pNotOut=0,dNotOut=0,pBowled=0,pHitWicket=0,pCaught=0,p6Out=0,dBowled=0,dHitWicket=0,dCaught=0,d6Out=0,pWon=0,dWon=0,pHS=0,pHSB,dHS=0,dHSB,dToss=0,pToss=0;
  double pSR,dSR,pAvg,dAvg;
  bool pHSNotOut=false,dHSNotOut=false;

  _TotalStatsState(this.statsQuery){
    for(int i=0;i<statsQuery.documents.length;i++){
      if(statsQuery.documents[i].data['FirstBat']=="Pawan"){
        matches+=1;
        pToss+=1;
        pRuns+=statsQuery.documents[i].data['FirstRuns'];
        pBalls+=statsQuery.documents[i].data['FirstBalls'];
        pExtra+=statsQuery.documents[i].data['FirstExtra'];
        dRuns+=statsQuery.documents[i].data['SecondRuns'];
        dBalls+=statsQuery.documents[i].data['SecondBalls'];
        dExtra+=statsQuery.documents[i].data['SecondExtra'];
        if((statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra'])>pHS){
          pHS=statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra'];
          pHSB=statsQuery.documents[i].data['FirstBalls'];
          if(statsQuery.documents[i].data['FirstOutMethod']=="NotOut"){
            pHSNotOut=true;
          }
        }
        if((statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra'])>dHS){
          dHS=statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra'];
          dHSB=statsQuery.documents[i].data['SecondBalls'];
          if(statsQuery.documents[i].data['SecondOutMethod']=="NotOut"){
            dHSNotOut=true;
          }
        }
        if(statsQuery.documents[i].data['FirstRuns']>statsQuery.documents[i].data['SecondRuns']){
          pWon+=1;
        }
        else{
          dWon+=1;
        }
        if(statsQuery.documents[i].data['FirstOutMethod']=="NotOut"){
          pNotOut+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="Bowled"){
          pBowled+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="HitWicket"){
          pHitWicket+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="Caught"){
          pCaught+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="6Out"){
          p6Out+=1;
        }
        if(statsQuery.documents[i].data['SecondOutMethod']=="NotOut"){
          dNotOut+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="Bowled"){
          dBowled+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="HitWicket"){
          dHitWicket+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="Caught"){
          dCaught+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="6Out"){
          d6Out+=1;
        }
        if(statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra']>=50){
          if(statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra']>=100){
            pCentury+=1;
          }
          else{
            pFifty+=1;
          }
        }
        if(statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra']>=50){
          if(statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra']>=100){
            dCentury+=1;
          }
          else{
            dFifty+=1;
          }
        }
      }
      else{
        matches+=1;
        dToss+=1;
        dRuns+=statsQuery.documents[i].data['FirstRuns'];
        dBalls+=statsQuery.documents[i].data['FirstBalls'];
        dExtra+=statsQuery.documents[i].data['FirstExtra'];
        pRuns+=statsQuery.documents[i].data['SecondRuns'];
        pBalls+=statsQuery.documents[i].data['SecondBalls'];
        pExtra+=statsQuery.documents[i].data['SecondExtra'];
        if((statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra'])>dHS){
          dHS=statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra'];
          dHSB=statsQuery.documents[i].data['FirstBalls'];
          if(statsQuery.documents[i].data['FirstOutMethod']=="NotOut"){
            dHSNotOut=true;
          }
        }
        if((statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra'])>pHS){
          pHS=statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra'];
          pHSB=statsQuery.documents[i].data['SecondBalls'];
          if(statsQuery.documents[i].data['SecondOutMethod']=="NotOut"){
            pHSNotOut=true;
          }
        }
        if(statsQuery.documents[i].data['SecondRuns']>statsQuery.documents[i].data['FirstRuns']){
          pWon+=1;
        }
        else{
          dWon+=1;
        }
        if(statsQuery.documents[i].data['FirstOutMethod']=="NotOut"){
          dNotOut+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="Bowled"){
          dBowled+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="HitWicket"){
          dHitWicket+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="Caught"){
          dCaught+=1;
        }
        else if(statsQuery.documents[i].data['FirstOutMethod']=="6Out"){
          d6Out+=1;
        }
        if(statsQuery.documents[i].data['SecondOutMethod']=="NotOut"){
          pNotOut+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="Bowled"){
          pBowled+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="HitWicket"){
          pHitWicket+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="Caught"){
          pCaught+=1;
        }
        else if(statsQuery.documents[i].data['SecondOutMethod']=="6Out"){
          p6Out+=1;
        }
        if(statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra']>=50){
          if(statsQuery.documents[i].data['SecondRuns']-statsQuery.documents[i].data['SecondExtra']>=100){
            pCentury+=1;
          }
          else{
            pFifty+=1;
          }
        }
        if(statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra']>=50){
          if(statsQuery.documents[i].data['FirstRuns']-statsQuery.documents[i].data['FirstExtra']>=100){
            dCentury+=1;
          }
          else{
            dFifty+=1;
          }
        }
      }
    }
    pRuns=pRuns-pExtra;
    dRuns=dRuns-dExtra;
    pSR=((pRuns)/pBalls)*100;
    dSR=((dRuns)/dBalls)*100;
    pAvg=pRuns/(matches-pNotOut);
    dAvg=dRuns/(matches-dNotOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LCL Total Stats"),
      ),
      body: Container(
        color: Colors.limeAccent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Card(
                  color: Colors.pinkAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top:10.0,right:10.0),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                height: 60.0,
                                child: Image.asset('assets/Pawan_appicon.jpeg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              child: Text("Pawan",style: TextStyle(color: Colors.tealAccent[400],fontWeight: FontWeight.bold,fontSize: 20.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Matches : "+matches.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Runs : "+pRuns.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("50s/100s : "+pFifty.toString()+"/"+pCentury.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("HS : "+pHS.toString()+"("+pHSB.toString()+")"+(pHSNotOut?"*":""),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("NotOut : "+pNotOut.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Wickets : "+(matches-dNotOut).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Avg : "+pAvg.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("SR : "+pSR.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Bowled : "+pBowled.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Caught : "+pCaught.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("6Out : "+p6Out.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("HitWicket : "+pHitWicket.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Won : "+pWon.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Toss : "+pToss.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(color: Colors.yellowAccent,indent: 10.0,endIndent: 50.0,width: 20.0,thickness: 3.0,),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,top:10.0,right:10.0),
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                height: 60.0,
                                child: Image.asset('assets/Dhanush_appicon.jpeg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              child: Text("Dhanush",style: TextStyle(color: Colors.tealAccent[400],fontWeight: FontWeight.bold,fontSize: 20.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Matches : "+matches.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Runs : "+dRuns.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("50s/100s : "+dFifty.toString()+"/"+dCentury.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("HS : "+dHS.toString()+"("+dHSB.toString()+")"+(dHSNotOut?"*":""),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("NotOut : "+dNotOut.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Wickets : "+(matches-pNotOut).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Avg : "+dAvg.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("SR : "+dSR.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Bowled : "+dBowled.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Caught : "+dCaught.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("6Out : "+d6Out.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("HitWicket : "+dHitWicket.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Won : "+dWon.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text("Toss : "+dToss.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
