
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

Capture cam;
MultiMarker nya;
int i= 0;
PImage img;
FindIterable<Document> result1, result2, result3;
Document latest1, latest2, latest3;
int year, month, day;

Calendar cal = Calendar.getInstance();

ArrayList<Float> beacons101x = new ArrayList<Float>();
ArrayList<Float> beacons101y = new ArrayList<Float>();
ArrayList<Long> time = new ArrayList<Long>();

long timeMin, timeMax;


MongoClient mongoClient = new MongoClient("150.89.234.253", 27017);

MongoDatabase database = mongoClient.getDatabase("myproject-room");

MongoCollection<Document> collection = database.getCollection("beacons1mz");

void setup(){
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addNyIdMarker(0, 80);
  cam.start();
  
  frameRate(20);
    
  img = loadImage("lab.PNG");
  
  cal.set(year(), month()-1, day(), 0, 0, 0);
  Date d = cal.getTime();
  
  println("FILTER DATE: " + d.toString());
  FindIterable<Document> result1 = collection.find(Filters.and(Filters.eq("minor" ,101),Filters.gte("date",d))).sort(Sorts.descending("date"));
  FindIterable<Document> result2 = collection.find(Filters.eq("minor" ,102)).sort(Sorts.descending("date"));
  FindIterable<Document> result3 = collection.find(Filters.eq("minor" ,103)).sort(Sorts.descending("date"));

  latest1 = result1.first();
  latest2 = result2.first();
  latest3 = result3.first();
  
  i = 0;
  for(Document doc : result1){
    if(i%5 == 0){
      float a = doc.getDouble("x").floatValue();
      beacons101x.add(a);
    
      float b = doc.getDouble("y").floatValue();
      beacons101y.add(b);
      
      Date d1 = doc.getDate("date");
      long b1 = d1.getTime();
      println("TIME[" + i + "]: " + b1);
      time.add(b1);
     }
    i++;
  }
  
  
  Date timemax = latest1.getDate("date");
  timeMax = timemax.getTime();
  println("MAX:" + timeMax);
  timeMin = timemax.getTime();
  for(i = 0; i < time.size(); i++){
    if(timeMin > time.get(i)){
      timeMin = time.get(i);
    }
  }


}


void draw(){
  if (cam.available() !=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);//frustumを考慮した背景描画
  if ((!nya.isExist(0))) {
    return;
  }
  nya.beginTransform(0);
  fill(0,0,225);
  translate(0,0,20);
  i = 0;
    
  beginShape(QUAD);
  textureMode(NORMAL);
  texture(img);
  vertex(-100,-125,1,1);
  vertex(-100,125,1,0);
  vertex(100,125,0,0);
  vertex(100,-125,0,1);
  endShape();
    
    
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

  rotateX(PI);
  rotateY(PI);
  
  fill(255,255,255);
  
  beginShape(QUAD);
  vertex(-105,150,1,1);
  vertex(-105,130,1,0);
  vertex(105,130,0,0);
  vertex(105,150,0,1);
  endShape();
  
  scale(0.7);
  
  translate(0,0,5);
  fill(0,0,0);
  DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  String timeMinStr = df.format(timeMin);
  String timeMaxStr = df.format(timeMax);
  
  text(""+timeMinStr+"~"+timeMaxStr, -140, 200);
  translate(0,0,-5);
  
  nya.endTransform();
} 


void beaconsdata(float x, float y){
  float x_1, y_1, x1, y1;
  
  x_1 = x * -22.5;
  y_1 = y * -21.739;
  
  x1 = 100 + x_1;
  y1 = 125 + y_1;
  
  
  translate(x1,y1,0);
  sphere(4);
  translate(-x1,-y1,0);
}

void drawline(float a, float b,float c, float d){
  float a1, b1, c1, d1;
  float a2, b2, c2, d2;
  
  a1 = a * -22.5;
  b1 = b * -21.739;
  
  c1 = c * -22.5;
  d1 = d * -21.739;
  
  a2 = 100 + a1;
  b2 = 125 + b1;
  
  c2 = 100 + c1;
  d2 = 125 + d1;
  
  line(a2, b2, c2, d2);
}