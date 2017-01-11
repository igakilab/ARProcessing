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

ControlP5 Button;
boolean aa = true, bb = false;
Capture cam;
MultiMarker nya;
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数

float[] Humid = new float[45];
float[] tem = new float[45];
float[] co2 = new float[45];
float[] noise = new float[45];
long[] time = new long[45];
FindIterable<Document> result, result_ascend;
Document latest;
int i = 0;
int id0,id1,id2,id3;

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


void setup(){
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  id0 = nya.addNyIdMarker(0, 80);
  id1 = nya.addNyIdMarker(1, 80);
  id2 = nya.addNyIdMarker(2, 80);
  id3 = nya.addNyIdMarker(3, 80);
  cam.start();
  
  Button = new ControlP5(this);
  Button.addButton("now")
        .setValue(0)
        .setPosition(10,10)
        .setSize(50,20);
  
  Button.addButton("graph")
        .setValue(100)
        .setPosition(70,10)
        .setSize(60,10);
  
  minim = new Minim(this);  //初期化
  player = minim.loadFile("button01a.mp3");  
  
  FindIterable<Document> result = collection.find().sort(Sorts.descending("date")).limit(45);
  latest = result.first();
  
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
  for(i = 0; i < 45; i++){
    if(timeMin > time[i]){
      timeMin = time[i];
    }
  }
  println("MIN:" + timeMin);
  
  dataMin = 0;
  
}


void draw(){
  if (cam.available() !=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);//frustumを考慮した背景描画
  if ((!nya.isExist(id0))&&(!nya.isExist(id1))&&(!nya.isExist(id2))&&(!nya.isExist(id3))) {
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
          dataMax = tem[i];
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
      for(i = 0; i < tem.length; i++){
        if ( dataMax < tem[i]){
          dataMax = tem[i];
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
      for(i = 0; i < tem.length; i++){
        if ( dataMax < tem[i]){
          dataMax = tem[i];
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
}

void now(){
  aa = !aa;
}

void graph(){
  bb = !bb;
}

//netatmoの現在のデータ
void environment(){


  fill(255,255,255);
  translate(-150, -150,-10);
  rect(0,0,300,300);
  translate(150,150,10);
  
  float tem  = 0.0;
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
  text("temperature : "+tem+"℃", 0, 0);
  
  if( Humidity > 60){
    fill(255,0,0);    
  }else if( tem < 38){
    fill(0,0,255);
  }
  else {
    fill(0,255,0);
  }
  text("Humidity : "+Humidity+"%", 0, 10);
  
  if( CO2 > 1500){
    fill(255,0,0);    
  }else if( CO2 > 700){
    fill(0,255,0);
  }else{
    fill(0,0,255);
  }
  text("CO2 : "+CO2+"ppm", 0, 20);
  
  if( Noise > 60){
    fill(255,0,0);
  }else if( Noise > 50){
    fill(0,255,0);
  }else{
    fill(0,0,255);
  }
  text("Noise : "+Noise+"dB", 0, 30);
  
  translate(-50,0, 0);
  box(10,10,Noise*6);
  
  
  translate(0,50,0);
  fill(0,0,0);
  text("CO2 concentration",-30,25);
  fill(255,255,0,CO2/15);
  ellipse(0,50,50,50);
}



//グラフの準備
void graphsetup(){
  fill(255,255,255);
  translate(-150, -145,-10);
  rect(0,0,300,240);
  translate(150,145,10);
  
  translate(150,100,5);
  scale(0.5);
  
  rotateX(PI);
  rotateY(PI);
  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);
  
}

//タイトルの表示
void drawTitle(String a){
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text(""+a+" History", plotX1,plotY1-10);
}

//グラフのそれぞれの軸のラベルの表示
void drawAxisLabels(String a){
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  text(""+a, labelX, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Time", (plotX1+plotX2)/2, labelY);
}

//グラフの横軸の表示
void drawTimeLabels(float Humid[]) {
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

//グラフの縦軸の表示
void drawVolumeLabels() {
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

//指定した配列をプロットする
void drawDataPoints(float Humid[]) {
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
        strokeWeight(5);
        line(x1,y1,x,y);
        translate(0,0,-5);
        println(Humid[row]);
    }
  }
  endShape();
}