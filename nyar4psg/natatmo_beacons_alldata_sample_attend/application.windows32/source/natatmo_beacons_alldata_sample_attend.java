import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 
import ddf.minim.signals.*; 
import ddf.minim.spi.*; 
import ddf.minim.ugens.*; 
import jp.nyatla.nyar4psg.*; 
import jp.nyatla.nyar4psg.utils.*; 
import processing.video.*; 
import com.mongodb.*; 
import com.mongodb.annotations.*; 
import com.mongodb.assertions.*; 
import com.mongodb.async.*; 
import com.mongodb.binding.*; 
import com.mongodb.bulk.*; 
import com.mongodb.client.*; 
import com.mongodb.client.gridfs.*; 
import com.mongodb.client.gridfs.codecs.*; 
import com.mongodb.client.gridfs.model.*; 
import com.mongodb.client.model.*; 
import com.mongodb.client.model.geojson.*; 
import com.mongodb.client.model.geojson.codecs.*; 
import com.mongodb.client.result.*; 
import com.mongodb.connection.*; 
import com.mongodb.connection.netty.*; 
import com.mongodb.diagnostics.logging.*; 
import com.mongodb.event.*; 
import com.mongodb.gridfs.*; 
import com.mongodb.internal.*; 
import com.mongodb.internal.async.*; 
import com.mongodb.internal.authentication.*; 
import com.mongodb.internal.connection.*; 
import com.mongodb.internal.management.jmx.*; 
import com.mongodb.internal.thread.*; 
import com.mongodb.internal.validator.*; 
import com.mongodb.management.*; 
import com.mongodb.operation.*; 
import com.mongodb.selector.*; 
import com.mongodb.util.*; 
import org.bson.*; 
import org.bson.assertions.*; 
import org.bson.codecs.*; 
import org.bson.codecs.configuration.*; 
import org.bson.conversions.*; 
import org.bson.diagnostics.*; 
import org.bson.io.*; 
import org.bson.json.*; 
import org.bson.types.*; 
import org.bson.util.*; 
import java.util.*; 
import java.text.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class natatmo_beacons_alldata_sample_attend extends PApplet {






























































ControlP5 Button;
ControlFont font;
boolean aa = true, bb = false;
Capture cam;
MultiMarker nya;
Minim minim;  //Minim\u578b\u5909\u6570\u3067\u3042\u308bminim\u306e\u5ba3\u8a00
AudioPlayer player;  //\u30b5\u30a6\u30f3\u30c9\u30c7\u30fc\u30bf\u683c\u7d0d\u7528\u306e\u5909\u6570

float[] Humid = new float[145];
float[] tem = new float[145];
float[] co2 = new float[145];
float[] noise = new float[145];
long[] time = new long[145];
FindIterable<Document> result,result1,result2,result3,result4,result5,result6;
FindIterable<Document> result7,result8,result9,result10,result11,result12;

Document latest,latest1,latest2,latest3,latest4,latest5,latest6;
Document latest7,latest8,latest9,latest10,latest11,latest12;

int i = 0;
int id0,id1,id2,id3,id4,id5,id6,id7,id8,id9, id10,id11,id12,id13,id14,id15,id16;
PImage img;

Calendar cal = Calendar.getInstance();

ArrayList<Float> beacons101x = new ArrayList<Float>();
ArrayList<Float> beacons101y = new ArrayList<Float>();

ArrayList<Float> beacons102x = new ArrayList<Float>();
ArrayList<Float> beacons102y = new ArrayList<Float>();

ArrayList<Float> beacons103x = new ArrayList<Float>();
ArrayList<Float> beacons103y = new ArrayList<Float>();

ArrayList<Float> beacons104x = new ArrayList<Float>();
ArrayList<Float> beacons104y = new ArrayList<Float>();

ArrayList<Float> beacons105x = new ArrayList<Float>();
ArrayList<Float> beacons105y = new ArrayList<Float>();

ArrayList<Float> beacons106x = new ArrayList<Float>();
ArrayList<Float> beacons106y = new ArrayList<Float>();

ArrayList<Float> beacons107x = new ArrayList<Float>();
ArrayList<Float> beacons107y = new ArrayList<Float>();

ArrayList<Float> beacons108x = new ArrayList<Float>();
ArrayList<Float> beacons108y = new ArrayList<Float>();

ArrayList<Float> beacons109x = new ArrayList<Float>();
ArrayList<Float> beacons109y = new ArrayList<Float>();

ArrayList<Float> beacons110x = new ArrayList<Float>();
ArrayList<Float> beacons110y = new ArrayList<Float>();

ArrayList<Float> beacons111x = new ArrayList<Float>();
ArrayList<Float> beacons111y = new ArrayList<Float>();

ArrayList<Float> beacons112x = new ArrayList<Float>();
ArrayList<Float> beacons112y = new ArrayList<Float>();

ArrayList<Long> Time1 = new ArrayList<Long>();
ArrayList<Long> Time2 = new ArrayList<Long>();
ArrayList<Long> Time3 = new ArrayList<Long>();
ArrayList<Long> Time4 = new ArrayList<Long>();
ArrayList<Long> Time5 = new ArrayList<Long>();
ArrayList<Long> Time6 = new ArrayList<Long>();
ArrayList<Long> Time7 = new ArrayList<Long>();
ArrayList<Long> Time8 = new ArrayList<Long>();
ArrayList<Long> Time9 = new ArrayList<Long>();
ArrayList<Long> Time10 = new ArrayList<Long>();
ArrayList<Long> Time11 = new ArrayList<Long>();
ArrayList<Long> Time12 = new ArrayList<Long>();


long timeMin1, timeMax1;
long timeMin2, timeMax2;
long timeMin3, timeMax3;
long timeMin4, timeMax4;
long timeMin5, timeMax5;
long timeMin6, timeMax6;
long timeMin7, timeMax7;
long timeMin8, timeMax8;
long timeMin9, timeMax9;
long timeMin10, timeMax10;
long timeMin11, timeMax11;
long timeMin12, timeMax12;


float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
float dataMin, dataMax;
long timeMin, timeMax;

String Tem = "Temperature";
String Hum = "Humidity";
String Co2 = "CO2";
String Noise = "Noise";

MongoClient mongoClient = new MongoClient("150.89.234.253", 27018);

MongoDatabase database = mongoClient.getDatabase("test");

MongoCollection<Document> collection = database.getCollection("netatmotest");

MongoClient mongoClient1 = new MongoClient("150.89.234.253", 27017);

MongoDatabase database1 = mongoClient1.getDatabase("myproject-room");

MongoCollection<Document> collection1 = database1.getCollection("beacons1mz");



public void setup(){
  
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  id0 = nya.addNyIdMarker(0, 80);
  id1 = nya.addNyIdMarker(1, 80);
  id2 = nya.addNyIdMarker(2, 80);
  id3 = nya.addNyIdMarker(3, 80);
  id4 = nya.addNyIdMarker(4, 80);
  id5 = nya.addNyIdMarker(5, 80);
  id6 = nya.addNyIdMarker(6, 80);
  id7 = nya.addNyIdMarker(7, 80);
  id8 = nya.addNyIdMarker(8, 80);
  id9 = nya.addNyIdMarker(9, 80);
  id10 = nya.addNyIdMarker(10, 80);
  id11 = nya.addNyIdMarker(11, 80);
  id12 = nya.addNyIdMarker(12, 80);
  id13 = nya.addNyIdMarker(13, 80);
  id14 = nya.addNyIdMarker(14, 80);
  id15 = nya.addNyIdMarker(15, 80);
  id16 = nya.addNyIdMarker(16, 80);

  
  cam.start();
  
  img = loadImage("lab.PNG");
  cal.set(year(), month()-1, day(), 0, 0, 0);
  Date d1 = cal.getTime();
  
  
  
  Button = new ControlP5(this);
  font = new ControlFont(createFont("ArialUnicodeMS-48",100));
  
  //createButton("now",0,10,10,100, 50, font);
  Button.addButton("now")
        .setValue(0)
        .setPosition(10,10)
        .setSize(100,50);
  
  Button.addButton("graph")
        .setLabel("history")
        .setValue(100)
        .setPosition(120,10)
        .setSize(100,50);
  
  minim = new Minim(this);  //\u521d\u671f\u5316
  player = minim.loadFile("button01a.mp3");  
  
  FindIterable<Document> result = collection.find().sort(Sorts.descending("date")).limit(145);
  latest = result.first();
  
  FindIterable<Document> result1 = collection1.find(Filters.and(Filters.eq("minor" ,101),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result2 = collection1.find(Filters.and(Filters.eq("minor" ,102),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result3 = collection1.find(Filters.and(Filters.eq("minor" ,103),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result4 = collection1.find(Filters.and(Filters.eq("minor" ,104),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result5 = collection1.find(Filters.and(Filters.eq("minor" ,105),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result6 = collection1.find(Filters.and(Filters.eq("minor" ,106),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result7 = collection1.find(Filters.and(Filters.eq("minor" ,107),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result8 = collection1.find(Filters.and(Filters.eq("minor" ,108),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result9 = collection1.find(Filters.and(Filters.eq("minor" ,109),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result10 = collection1.find(Filters.and(Filters.eq("minor" ,110),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result11 = collection1.find(Filters.and(Filters.eq("minor" ,111),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result12 = collection1.find(Filters.and(Filters.eq("minor" ,112),Filters.gte("date",d1))).sort(Sorts.descending("date"));

  latest1 = result1.first();
  latest2 = result2.first();
  latest3 = result3.first();
  latest4 = result4.first();
  latest5 = result5.first();
  latest6 = result6.first();
  latest7 = result7.first();
  latest8 = result8.first();
  latest9 = result9.first();
  latest10 = result10.first();
  latest11 = result11.first();
  latest12 = result12.first();

  
  i = tem.length-1;
  for(Document doc : result){
    float a = doc.getDouble("tem").floatValue();
    tem[i] = a;
    
    float c = doc.getInteger("Humidity").floatValue();
    Humid[i] = c;
    
    float e = doc.getInteger("CO2").floatValue();
    co2[i] = e;
    
    float f = doc.getInteger("Noise").floatValue();
    noise[i] = f;
    
    Date d = doc.getDate("date");
    long b = d.getTime();
    println("TIME[" + i + "]: " + b);
    time[i] = b;
    i--;
  }
  
  int i= 0;
  for(Document doc : result1){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons101x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons101y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time1.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result2){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons102x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons102y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time2.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result3){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons103x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons103y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time3.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result4){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons104x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons104y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time4.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result5){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons105x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons105y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time5.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result6){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons106x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons106y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time6.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result7){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons107x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons107y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time7.add(b2);
     }
    i++;
  }
  i= 0;

  for(Document doc : result8){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons108x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons108y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time8.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result9){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons109x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons109y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time9.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result10){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons110x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons110y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time10.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result11){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons111x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons111y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time11.add(b2);
     }
    i++;
  }
  i = 0;

  for(Document doc : result12){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons112x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons112y.add(b);
      
      Date d2 = doc.getDate("date");
      long b2 = d2.getTime();
      println("TIME[" + i + "]: " + b2);
      Time12.add(b2);
     }
    i++;
  }
  i = 0;
  
  if( latest1 != null ){
    Date timemax1 = latest1.getDate("date");
    timeMax1 = timemax1.getTime();
    timeMin1 = timemax1.getTime();
    for(i = 0; i < Time1.size(); i++){
      if(timeMin1 > Time1.get(i)){
        timeMin1 = Time1.get(i);
      }
    }
  }

  if( latest2 != null ){
    Date timemax2 = latest2.getDate("date");
    timeMax2 = timemax2.getTime();
    timeMin2 = timemax2.getTime();
    for(i = 0; i < Time2.size(); i++){
      if(timeMin2 > Time2.get(i)){
        timeMin2 = Time2.get(i);
      }
    }
  }
  
  if( latest3 != null ){
    Date timemax3 = latest3.getDate("date");
    timeMax3 = timemax3.getTime();
    timeMin3 = timemax3.getTime();
    for(i = 0; i < Time3.size(); i++){
      if(timeMin3 > Time3.get(i)){
        timeMin3 = Time3.get(i);
      }
    }
  }
  
  if( latest4 != null ){
    Date timemax4 = latest4.getDate("date");
    timeMax4 = timemax4.getTime();
    timeMin4 = timemax4.getTime();
    for(i = 0; i < Time4.size(); i++){
      if(timeMin4 > Time4.get(i)){
        timeMin4 = Time4.get(i);
      }
    }
  }
  
  if( latest5 != null ){
    Date timemax5 = latest5.getDate("date");
    timeMax5 = timemax5.getTime();
    timeMin5 = timemax5.getTime();
    for(i = 0; i < Time5.size(); i++){
      if(timeMin5 > Time5.get(i)){
        timeMin5 = Time5.get(i);
      }
    }
  }
  
  if( latest6 != null ){
    Date timemax6 = latest6.getDate("date");
    timeMax6 = timemax6.getTime();
    timeMin6 = timemax6.getTime();
    for(i = 0; i < Time6.size(); i++){
      if(timeMin6 > Time6.get(i)){
        timeMin6 = Time6.get(i);
      }
    }
  }
  
  if( latest7 != null ){
    Date timemax7 = latest7.getDate("date");
    timeMax7 = timemax7.getTime();
    timeMin7 = timemax7.getTime();
    for(i = 0; i < Time7.size(); i++){
      if(timeMin7 > Time7.get(i)){
        timeMin7 = Time7.get(i);
      }
    }
  }
  
  if( latest8 != null ){
    Date timemax8 = latest8.getDate("date");
    timeMax8 = timemax8.getTime();
    timeMin8 = timemax8.getTime();
    for(i = 0; i < Time8.size(); i++){
      if(timeMin8 > Time8.get(i)){
        timeMin8 = Time8.get(i);
      }
    }
  }
  
  if( latest9 != null ){
    Date timemax9 = latest9.getDate("date");
    timeMax9 = timemax9.getTime();
    timeMin9 = timemax9.getTime();
    for(i = 0; i < Time9.size(); i++){
      if(timeMin9 > Time9.get(i)){
        timeMin9 = Time9.get(i);
      }
    }
  }
  
  if( latest10 != null ){
    Date timemax10 = latest10.getDate("date");
    timeMax10 = timemax10.getTime();
    timeMin10 = timemax10.getTime();
    for(i = 0; i < Time10.size(); i++){
      if(timeMin10 > Time10.get(i)){
        timeMin10 = Time10.get(i);
      }
    }
  }
  
  if( latest11 != null ){
    Date timemax11 = latest11.getDate("date");
    timeMax11 = timemax11.getTime();
    timeMin11 = timemax11.getTime();
    for(i = 0; i < Time11.size(); i++){
      if(timeMin11 > Time11.get(i)){
        timeMin11 = Time11.get(i);
      }
    }
  }
  
  if( latest12 != null ){
    Date timemax12 = latest12.getDate("date");
    timeMax12 = timemax12.getTime();
    timeMin12 = timemax12.getTime();
    for(i = 0; i < Time12.size(); i++){
      if(timeMin12 > Time12.get(i)){
        timeMin12 = Time12.get(i);
      }
    }
  }


  
  plotX1 = 120; 
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  Date timemax = latest.getDate("date");
  timeMax = timemax.getTime();
  println("MAX:" + timeMax);
  timeMin = timemax.getTime();
  for(i = 0; i < time.length; i++){
    if(timeMin > time[i]){
      timeMin = time[i];
    }
  }
  println("MIN:" + timeMin);
  
  dataMin = 0;
  
}


public void draw(){
  if (cam.available() !=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);//frustum\u3092\u8003\u616e\u3057\u305f\u80cc\u666f\u63cf\u753b
  if ((!nya.isExist(id0))&&(!nya.isExist(id1))&&(!nya.isExist(id2))&&(!nya.isExist(id3))&&(!nya.isExist(id4))&&(!nya.isExist(id5))&&(!nya.isExist(id6))&&(!nya.isExist(id7))
  &&(!nya.isExist(id8))&&(!nya.isExist(id9))&&(!nya.isExist(id10))&&(!nya.isExist(id11))&&(!nya.isExist(id12))&&(!nya.isExist(id13))&&(!nya.isExist(id14))&&(!nya.isExist(id15))&&(!nya.isExist(id16))) {
    return;
  }
  if((nya.isExist(id0))){
    nya.beginTransform(id0); 
    fill(0,0,225);
    translate(0,0,20);

    if( aa ){
      
      environment();
    }

    if( bb ){
      
      graphsetup();
      
      dataMax = 0;
      for(i = 0; i < tem.length; i++){
        if ( dataMax < tem[i]){
          dataMax = tem[i];
        }
      }
    
      drawTitle(Tem);
      
      drawAxisLabels(Tem);
      drawTimeLabels(tem);
      drawVolumeLabels();
      
      drawDataPoints(tem);
      
      DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String timeMinStr = df.format(timeMin);
      String timeMaxStr = df.format(timeMax);
      
      text(""+timeMinStr+"~"+timeMaxStr, (plotX1+plotX2)/2, plotY1-40);
    }
  nya.endTransform();
  
  
  }
  if(nya.isExist(id1)){
    nya.beginTransform(id1); 
    fill(0,0,225);
    translate(0,0,20);

    if( aa ){
      
      environment();
    }

    if( bb ){
      
      graphsetup();
      dataMax = 0;
      for(i = 0; i < Humid.length; i++){
        if ( dataMax < Humid[i]){
          dataMax = Humid[i];
        }
      }
      
      drawTitle(Hum);
      
      drawAxisLabels(Hum);
      drawTimeLabels(Humid);
      drawVolumeLabels();
      
      drawDataPoints(Humid);
      
      DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String timeMinStr = df.format(timeMin);
      String timeMaxStr = df.format(timeMax);
      
      text(""+timeMinStr+"~"+timeMaxStr, (plotX1+plotX2)/2, plotY1-40);
      
      
    }
    nya.endTransform();
    
    
  }
  if(nya.isExist(id2)){
    nya.beginTransform(id2); 
    fill(0,0,225);
    translate(0,0,20);

    if( aa ){
      
      environment();
    }

    if( bb ){
      
      graphsetup();
      dataMax = 0;
      for(i = 0; i < co2.length; i++){
        if ( dataMax < co2[i]){
          dataMax = co2[i];
        }
      }
      
      drawTitle(Co2);
      
      drawAxisLabels(Co2);
      drawTimeLabels(co2);
      drawVolumeLabels();
      
      drawDataPoints(co2);
      
      DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String timeMinStr = df.format(timeMin);
      String timeMaxStr = df.format(timeMax);
      
      text(""+timeMinStr+"~"+timeMaxStr, (plotX1+plotX2)/2, plotY1-40);
      
      
    }
    nya.endTransform();
    
    
  }
  if(nya.isExist(id3)){
    nya.beginTransform(id3); 
    fill(0,0,225);
    translate(0,0,20);

    if( aa ){
      
      environment();
    }

    if( bb ){
      
      graphsetup();
      dataMax = 0;
      for(i = 0; i < noise.length; i++){
        if ( dataMax < noise[i]){
          dataMax = noise[i];
        }
      }
      
      drawTitle(Noise);
      
      drawAxisLabels(Noise);
      drawTimeLabels(noise);
      drawVolumeLabels();
      
      drawDataPoints(noise);
      
      DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String timeMinStr = df.format(timeMin);
      String timeMaxStr = df.format(timeMax);
      
      text(""+timeMinStr+"~"+timeMaxStr, (plotX1+plotX2)/2, plotY1-40);
      
      
    }
    
    nya.endTransform();
  }
    
  if(nya.isExist(id4)){
    nya.beginTransform(id4);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      lab();
      if(latest1 != null){
        float x1 = beacons101x.get(0);
        float y1 = beacons101y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
    i = 0;
    
    scale(1.3f);
    
    lab();    
    if(latest1 != null){
      if(i == 0){
        float x1 = beacons101x.get(0);
        float y1 = beacons101y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
      if(i > 0){
        for(i= 1; i < beacons101x.size()-1; i++){
         float x1 = beacons101x.get(i);
         float y1 = beacons101y.get(i);
         
         fill(0,0,0);
         beaconsdata(x1,y1);
         //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
         stroke(0,0,0);
         drawline(x1,y1,beacons101x.get(i-1),beacons101y.get(i-1));
    
         
         println(i+":"+x1+":"+y1);
        }
        
        if(i == beacons101x.size()-1){
          float x1 = beacons101x.get(beacons101x.size()-1);
          float y1 = beacons101y.get(beacons101x.size()-1);
          
          noStroke();
          fill(0,0,255);
          beaconsdata(x1,y1);
          stroke(0,0,0);
          drawline(x1,y1,beacons101x.get(i-1),beacons101y.get(i-1));
    
          println(i+":"+x1+":"+y1);
        }
      }
    }
    
    rotateX(PI);
    rotateY(PI);
    
    fill(255,255,255);
    
    beginShape(QUAD);
    vertex(-105,150,1,1);
    vertex(-105,130,1,0);
    vertex(105,130,0,0);
    vertex(105,150,0,1);
    endShape();
    
    scale(0.74f);
    
    labtime(timeMin1, timeMax1);
    }
  
    nya.endTransform();
  }

  
    if(nya.isExist(id5)){
    nya.beginTransform(id5);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      scale(1.3f);
      lab();
      if(latest2 != null){
        float x1 = beacons102x.get(0);
        float y1 = beacons102y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
      
      lab();
        
      
      if(latest2 != null){
        if(i == 0){
          float x1 = beacons102x.get(0);
          float y1 = beacons102y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons102x.size()-1; i++){
           float x1 = beacons102x.get(i);
           float y1 = beacons102y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons102x.get(i-1),beacons102y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons102x.size()-1){
            float x1 = beacons102x.get(beacons102x.size()-1);
            float y1 = beacons102y.get(beacons102x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons102x.get(i-1),beacons102y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin2, timeMax2); 
    }
    nya.endTransform();
  }
  
    if(nya.isExist(id6)){
    nya.beginTransform(id6);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      scale(1.3f);
      lab();
      if(latest3 != null){
        float x1 = beacons103x.get(0);
        float y1 = beacons103y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest3 != null){
        if(i == 0){
          float x1 = beacons103x.get(0);
          float y1 = beacons103y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons103x.size()-1; i++){
           float x1 = beacons103x.get(i);
           float y1 = beacons103y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons103x.get(i-1),beacons103y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons101x.size()-1){
            float x1 = beacons103x.get(beacons103x.size()-1);
            float y1 = beacons103y.get(beacons103x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons103x.get(i-1),beacons103y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin3, timeMax3);
    }
  
    nya.endTransform();
  }

  if(nya.isExist(id7)){
    nya.beginTransform(id7);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      scale(1.3f);
      lab();
      if(latest4 != null){
        float x1 = beacons104x.get(0);
        float y1 = beacons104y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      
      if(latest4 != null){
        if(i == 0){
          float x1 = beacons104x.get(0);
          float y1 = beacons104y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons104x.size()-1; i++){
           float x1 = beacons104x.get(i);
           float y1 = beacons104y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons104x.get(i-1),beacons104y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons104x.size()-1){
            float x1 = beacons104x.get(beacons104x.size()-1);
            float y1 = beacons104y.get(beacons104x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons104x.get(i-1),beacons104y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin4, timeMax4);
    }
  
    nya.endTransform();
  }

  if(nya.isExist(id8)){
    nya.beginTransform(id8);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      scale(1.3f);
      lab();
      if(latest5 != null){
        float x1 = beacons105x.get(0);
        float y1 = beacons105y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest5 != null){
        if(i == 0){
          float x1 = beacons105x.get(0);
          float y1 = beacons105y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons105x.size()-1; i++){
           float x1 = beacons105x.get(i);
           float y1 = beacons105y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons105x.get(i-1),beacons105y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons105x.size()-1){
            float x1 = beacons105x.get(beacons105x.size()-1);
            float y1 = beacons105y.get(beacons105x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons105x.get(i-1),beacons105y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin5, timeMax5);
    }
  
    nya.endTransform();
  }

  if(nya.isExist(id9)){
    nya.beginTransform(id9);
    fill(0,0,225);
    translate(0,0,20);
    if( aa) {
      scale(1.3f);
      lab();
      if(latest6 != null){
        float x1 = beacons106x.get(0);
        float y1 = beacons106y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest6 != null){
        if(i == 0){
          float x1 = beacons106x.get(0);
          float y1 = beacons106y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons106x.size()-1; i++){
           float x1 = beacons106x.get(i);
           float y1 = beacons106y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons106x.get(i-1),beacons106y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons106x.size()-1){
            float x1 = beacons106x.get(beacons106x.size()-1);
            float y1 = beacons106y.get(beacons106x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons106x.get(i-1),beacons106y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin6, timeMax6);
    }
  
    nya.endTransform();
  }

  if(nya.isExist(id10)){
    nya.beginTransform(id10);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      scale(1.3f);
      lab();
      if(latest7 != null){
        float x1 = beacons107x.get(0);
        float y1 = beacons107y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest7 != null){
        if(i == 0){
          float x1 = beacons107x.get(0);
          float y1 = beacons107y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons107x.size()-1; i++){
           float x1 = beacons107x.get(i);
           float y1 = beacons107y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons107x.get(i-1),beacons107y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons107x.size()-1){
            float x1 = beacons107x.get(beacons107x.size()-1);
            float y1 = beacons107y.get(beacons107x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons107x.get(i-1),beacons107y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin7, timeMax7);
    }
  
  
    nya.endTransform();
  }

  if(nya.isExist(id11)){
    nya.beginTransform(id11);
    fill(0,0,225);
    translate(0,0,20);
    
    if( aa) {
      environment();scale(1.3f);
      lab();
      if(latest8 != null){
        float x1 = beacons108x.get(0);
        float y1 = beacons108y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest8 != null){
        if(i == 0){
          float x1 = beacons108x.get(0);
          float y1 = beacons108y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons108x.size()-1; i++){
           float x1 = beacons108x.get(i);
           float y1 = beacons108y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons108x.get(i-1),beacons108y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons108x.size()-1){
            float x1 = beacons108x.get(beacons108x.size()-1);
            float y1 = beacons108y.get(beacons108x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons108x.get(i-1),beacons108y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
      
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin8, timeMax8);
    }
    
  
    nya.endTransform();
  }

  if(nya.isExist(id12)){
    nya.beginTransform(id12);
    fill(0,0,225);
    translate(0,0,20);
    if( aa) {
      scale(1.3f);
      lab();
      if(latest9 != null){
        float x1 = beacons109x.get(0);
        float y1 = beacons109y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest9 != null){
        if(i == 0){
          float x1 = beacons109x.get(0);
          float y1 = beacons109y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons109x.size()-1; i++){
           float x1 = beacons109x.get(i);
           float y1 = beacons109y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons109x.get(i-1),beacons109y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons109x.size()-1){
            float x1 = beacons109x.get(beacons109x.size()-1);
            float y1 = beacons109y.get(beacons109x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons109x.get(i-1),beacons109y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin9, timeMax9);
    }
  
    nya.endTransform();
  }

  if(nya.isExist(id13)){
    nya.beginTransform(id13);
    fill(0,0,225);
    translate(0,0,20);
    if( aa) {
      scale(1.3f);
      lab();
      if(latest10 != null){
        float x1 = beacons110x.get(0);
        float y1 = beacons110y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest10 != null){
        if(i == 0){
          float x1 = beacons110x.get(0);
          float y1 = beacons110y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons110x.size()-1; i++){
           float x1 = beacons110x.get(i);
           float y1 = beacons110y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons110x.get(i-1),beacons110y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons110x.size()-1){
            float x1 = beacons110x.get(beacons110x.size()-1);
            float y1 = beacons110y.get(beacons110x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons110x.get(i-1),beacons110y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin10, timeMax10);
    }        
  
    nya.endTransform();
  }

  if(nya.isExist(id14)){
    nya.beginTransform(id14);
    fill(0,0,225);
    translate(0,0,20);
    if( aa) {
      scale(1.3f);
      lab();
      if(latest11 != null){
        float x1 = beacons111x.get(0);
        float y1 = beacons111y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest11 != null){
        if(i == 0){
          float x1 = beacons111x.get(0);
          float y1 = beacons111y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons111x.size()-1; i++){
           float x1 = beacons111x.get(i);
           float y1 = beacons111y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons111x.get(i-1),beacons111y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons111x.size()-1){
            float x1 = beacons111x.get(beacons111x.size()-1);
            float y1 = beacons111y.get(beacons111x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons111x.get(i-1),beacons111y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin11, timeMax11);
    }
    nya.endTransform();
  }

  if(nya.isExist(id15)){
    nya.beginTransform(id15);
    fill(0,0,225);
    translate(0,0,20);
    if( aa) {
      scale(1.3f);
      lab();
      if(latest12 != null){
        float x1 = beacons112x.get(0);
        float y1 = beacons112y.get(0);
        
        noStroke();
        fill(255,0,0);
        beaconsdata(x1,y1);
        println(i+":"+x1+":"+y1);
        i++;
      }
    }
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
        
      if(latest12 != null){
        if(i == 0){
          float x1 = beacons112x.get(0);
          float y1 = beacons112y.get(0);
          
          noStroke();
          fill(255,0,0);
          beaconsdata(x1,y1);
          println(i+":"+x1+":"+y1);
          i++;
        }
        if(i > 0){
          for(i= 1; i < beacons112x.size()-1; i++){
           float x1 = beacons112x.get(i);
           float y1 = beacons112y.get(i);
           
           fill(0,0,0);
           beaconsdata(x1,y1);
           //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
           stroke(0,0,0);
           drawline(x1,y1,beacons112x.get(i-1),beacons112y.get(i-1));
      
           
           println(i+":"+x1+":"+y1);
          }
          
          if(i == beacons112x.size()-1){
            float x1 = beacons112x.get(beacons112x.size()-1);
            float y1 = beacons112y.get(beacons112x.size()-1);
            
            noStroke();
            fill(0,0,255);
            beaconsdata(x1,y1);
            stroke(0,0,0);
            drawline(x1,y1,beacons112x.get(i-1),beacons112y.get(i-1));
      
            println(i+":"+x1+":"+y1);
          }
        }
      }
    
      rotateX(PI);
      rotateY(PI);
      
      fill(255,255,255);
      
      beginShape(QUAD);
      vertex(-105,150,1,1);
      vertex(-105,130,1,0);
      vertex(105,130,0,0);
      vertex(105,150,0,1);
      endShape();
      
      scale(0.74f);
      
      labtime(timeMin12, timeMax12);
    }
  
    nya.endTransform();
  }
  
  if(nya.isExist(id16)){
    nya.beginTransform(id16);
    fill(0,0,225);
    translate(0,0,20);
    
    
    if( bb){
      i = 0;
      
      scale(1.3f);
        
      lab();
      
      if(beacons101x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,-35,4,4);
        translate(0,0,-10);
      }
      if(beacons102x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,-55,4,4);
        translate(0,0,-10);
      }
      if(beacons103x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,85,4,4);
        translate(0,0,-10);
      }
      if(beacons104x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,105,4,4);
        translate(0,0,-10);
      }
      if(beacons105x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,65,4,4);
        translate(0,0,-10);
      }
      if( beacons106x.size()> 5 ){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,45,4,4);
        translate(0,0,-10);
      }
      if( beacons107x.size()> 5 ){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,25,4,4);
        translate(0,0,-10);
      }
      if( beacons108x.size()> 5 ){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,5,4,4);
        translate(0,0,-10);
      }
      if( beacons109x.size()> 5 ){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(75,-15,4,4);
        translate(0,0,-10);
      }
      if( beacons110x.size()> 5 ){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
       ellipse(65,-85,4,4);
        translate(0,0,-10);
      }
      if(beacons111x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(40,-85,4,4);
        translate(0,0,-10);
      }
      if(beacons112x.size()> 5){
        translate(0,0,10);
        noStroke();
        fill(255,0,0);
        ellipse(15,-85,4,4);
        translate(0,0,-10);
      }
    }
      nya.endTransform();
  }


}

public void now(){
  aa = !aa;
}

public void graph(){
  bb = !bb;
}

//Button createButton(String theName, int theValue, int theX, int theY, int theZ, int theW,ControlFont theFont){
//  Button b = Button.addButton(theName)
//        .setValue(theValue)
//        .setPosition(theX,theY)
//        .setSize(theZ, theW)
//        .captionLabel().setControlFont(theFont);
//  return b;
//}

//netatmo\u306e\u73fe\u5728\u306e\u30c7\u30fc\u30bf
public void environment(){


  fill(255,255,255);
  translate(-150, -150,-10);
  rect(0,0,300,300);
  translate(150,150,10);
  
  float tem  = 0.0f;
  Integer Humidity = 0, CO2 = 0, Noise = 0;
  
  
  tem = latest.getDouble("tem").floatValue();
  Humidity = latest.getInteger("Humidity");
  CO2 = latest.getInteger("CO2");
  Noise = latest.getInteger("Noise");
  
  fill(0);
  
  rotateX(PI);
  rotateY(PI);
  
  fill(0,0,0);
  if( tem >= 26){
    fill(255,0,0);    
  }else if( tem < 22){
    fill(0,0,255);
  }
  else {
    fill(0,255,0);
  }
  textSize(16);
  text("temperature : "+tem+"\u2103", 130, -20);
  
  if( Humidity > 60){
    fill(255,0,0);    
  }else if( tem < 38){
    fill(0,0,255);
  }
  else {
    fill(0,255,0);
  }
  text("Humidity : "+Humidity+"%", 130, 0);
  
  if( CO2 > 1500){
    fill(255,0,0);    
  }else if( CO2 > 700){
    fill(0,255,0);
  }else{
    fill(0,0,255);
  }
  text("CO2 : "+CO2+"ppm", 130, 20);
  translate(-50,60,0);
  fill(0,0,0);
  text("CO2 concentration",50,25);
  
  if( CO2 > 1500){
    fill(255,0,0,CO2/15);    
  }else if( CO2 > 700){
    fill(0,255,0,CO2/30);
  }else{
    fill(0,0,255,CO2);
  }
  
  ellipse(0,50,50,50);
  translate(50,-60,0);
  
  if( Noise > 60){
    fill(255,0,0);
  }else if( Noise > 50){
    fill(0,255,0);
  }else{
    fill(0,0,255);
  }
  text("Noise : "+Noise+"dB", 130, 40);
  
  translate(-50,-20, 0);
  box(10,10,Noise*6);
  translate(50,20, 0);
  
  fill(0,0,0);
  text("Noise",-30,0);

}

public void lab(){
  translate(0,20,0);
  beginShape(QUAD);
  textureMode(NORMAL);
  texture(img);
  vertex(-100,-125,1,1);
  vertex(-100,125,1,0);
  vertex(100,125,0,0);
  vertex(100,-125,0,1);
  endShape();
  translate(0,-20,0);
}

public void labtime(long timeMin12, long timeMax12){
  translate(0,0,5);
  fill(0,0,0);
  DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  String timeMinStr = df.format(timeMin12);
  String timeMaxStr = df.format(timeMax12);
  
  text(""+timeMinStr+"~"+timeMaxStr, -140, 200);
  translate(0,0,-5);
}


//\u30b0\u30e9\u30d5\u306e\u6e96\u5099
public void graphsetup(){
  fill(255,255,255);
  translate(-150, -145,-10);
  rect(0,0,320,240);
  translate(150,145,10);
  
  translate(150,100,5);
  scale(0.5f);
  
  rotateX(PI);
  rotateY(PI);
  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);
  
}

//\u30bf\u30a4\u30c8\u30eb\u306e\u8868\u793a
public void drawTitle(String a){
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text(""+a+" History", plotX1,plotY1-10);
}

//\u30b0\u30e9\u30d5\u306e\u305d\u308c\u305e\u308c\u306e\u8ef8\u306e\u30e9\u30d9\u30eb\u306e\u8868\u793a
public void drawAxisLabels(String a){
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  text(""+a, labelX, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Time", (plotX1+plotX2)/2, labelY);
}

//\u30b0\u30e9\u30d5\u306e\u6a2a\u8ef8\u306e\u8868\u793a
public void drawTimeLabels(float Humid[]) {
  fill(0);
  textSize(10);
  textAlign(CENTER);
  
  stroke(224);
  strokeWeight(1);
  
  for(int i = 0; i < Humid.length; i++){
    if(i == 0 || (i+1 % 5 == 0)){
      float x = map(Humid[i], timeMin, timeMax, plotX2, plotX2);
      line(x,plotY1, x, plotY2);
    }
  }
}

//\u30b0\u30e9\u30d5\u306e\u7e26\u8ef8\u306e\u8868\u793a
public void drawVolumeLabels() {
  fill(0);
  textSize(10);
  textAlign(RIGHT);
  
  stroke(128);
  strokeWeight(1);
  
  if(dataMax <= 100){
    for (float v = dataMin; v <= dataMax+10; v += 5) {
      if (v % 5 == 0) {
        float y = map(v, dataMin, dataMax+10, plotY2, plotY1);  
        if (v % 10 == 0) {
          if (v == dataMin) {
            textAlign(RIGHT);
          } else if (v == dataMax+10) {
            textAlign(RIGHT, TOP);
          } else {
            textAlign(RIGHT, CENTER);
          }
          text(floor(v), plotX1 - 10, y);
          line(plotX1 - 4, y, plotX1, y);
        } else {
        line(plotX1 - 2, y, plotX1, y);
        }
      }
    }
  }else{
    for (float v = dataMin; v <= dataMax+100; v += 50) {
      if (v % 50 == 0) {
        float y = map(v, dataMin, dataMax+100, plotY2, plotY1);  
        if (v % 100 == 0) {
          if (v == dataMin) {
            textAlign(RIGHT);
          } else if (v == dataMax+10) {
            textAlign(RIGHT, TOP);
          } else {
            textAlign(RIGHT, CENTER);
          }
          text(floor(v), plotX1 - 10, y);
          line(plotX1 - 4, y, plotX1, y);
        } else {
        line(plotX1 - 2, y, plotX1, y);
        }
      }
    }
  }
}

//\u6307\u5b9a\u3057\u305f\u914d\u5217\u3092\u30d7\u30ed\u30c3\u30c8\u3059\u308b
public void drawDataPoints(float Humid[]) {
  beginShape();
  if(dataMax <= 100){
    float x0 = map(time[0], timeMin, timeMax, plotX1, plotX2);
    float y0 = map(Humid[0], dataMin, 50, plotY2, plotY1);
    for (int row = 1; row < Humid.length; row++) {
        if(row == 1){
          float x1 = map(time[row], timeMin, timeMax, plotX1, plotX2);
          float y1 = map(Humid[row], dataMin, dataMax+10, plotY2, plotY1);
          
          translate(0,0,5);
          ellipse(x1,y1,4,4);
          strokeWeight(5);
          line(x0,y0,x1,y1);
          translate(0,0,-5);
        }
        float x = map(time[row], timeMin, timeMax, plotX1, plotX2);
        float y = map(Humid[row], dataMin, dataMax+10, plotY2, plotY1);
        
        float x1 = map(time[row-1], timeMin, timeMax, plotX1, plotX2);
        float y1 = map(Humid[row-1], dataMin, dataMax+10, plotY2, plotY1);
        
        translate(0,0,5);
        ellipse(x,y,4,4);
        strokeWeight(5);
        line(x1,y1,x,y);
        translate(0,0,-5);
        println(Humid[row]);
    }
  }else{
    float x0 = map(time[0], timeMin, timeMax, plotX1, plotX2);
    float y0 = map(Humid[0], dataMin, 50, plotY2, plotY1);
    for (int row = 1; row < Humid.length; row++) {
        if(row == 1){
          float x1 = map(time[row], timeMin, timeMax, plotX1, plotX2);
          float y1 = map(Humid[row], dataMin, dataMax+100, plotY2, plotY1);
          
          translate(0,0,5);
          ellipse(x1,y1,4,4);
          strokeWeight(5);
          line(x0,y0,x1,y1);
          translate(0,0,-5);
        }
        float x = map(time[row], timeMin, timeMax, plotX1, plotX2);
        float y = map(Humid[row], dataMin, dataMax+100, plotY2, plotY1);
        
        float x1 = map(time[row-1], timeMin, timeMax, plotX1, plotX2);
        float y1 = map(Humid[row-1], dataMin, dataMax+100, plotY2, plotY1);
        
        translate(0,0,5);
        ellipse(x,y,4,4);
        noStroke();
        strokeWeight(5);
        line(x1,y1,x,y);
        translate(0,0,-5);
        println(Humid[row]);
    }
  }
  endShape();
}


public void beaconsdata(float x, float y){
  float x_1, y_1, x1, y1;
  
  x_1 = x * -22.5f;
  y_1 = y * -21.739f;
  
  x1 = 100 + x_1;
  y1 = 125 + y_1;
  
  
  translate(x1,y1,0);
  sphere(4);
  translate(-x1,-y1,0);
}

public void drawline(float a, float b,float c, float d){
  float a1, b1, c1, d1;
  float a2, b2, c2, d2;
  
  a1 = a * -22.5f;
  b1 = b * -21.739f;
  
  c1 = c * -22.5f;
  d1 = d * -21.739f;
  
  a2 = 100 + a1;
  b2 = 125 + b1;
  
  c2 = 100 + c1;
  d2 = 125 + d1;
  
  line(a2, b2, c2, d2);
}
  public void settings() {  size(640, 480, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "natatmo_beacons_alldata_sample_attend" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
