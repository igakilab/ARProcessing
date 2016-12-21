
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

Capture cam;
MultiMarker nya;
int i= 0;
PImage img;
FindIterable<Document> result1, result2, result3;
Document latest1, latest2, latest3;
int month = month();
int day = day();

ArrayList<Float> beacons101x = new ArrayList<Float>();
ArrayList<Float> beacons101y = new ArrayList<Float>();

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
        
  FindIterable<Document> result1 = collection.find(Filters.eq("minor" ,101)).sort(Sorts.descending("date"));
  FindIterable<Document> result2 = collection.find(Filters.eq("minor" ,102)).sort(Sorts.descending("date"));
  FindIterable<Document> result3 = collection.find(Filters.eq("minor" ,103)).sort(Sorts.descending("date"));

  latest1 = result1.first();
  latest2 = result2.first();
  latest3 = result3.first();
  
  i = 0;
  for(Document doc : result1){
    
    float a = doc.getDouble("x").floatValue();
    beacons101x.add(a);
  
    float b = doc.getDouble("y").floatValue();
    beacons101y.add(b);
    
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
    
    
  if(i == beacons101x.size()-1){
    float x1 = beacons101x.get(beacons101x.size()-1);
    float y1 = beacons101y.get(beacons101x.size()-1);
    
    fill(255,0,0);
    beaconsdata(x1,y1);
    i++;
  }
  if(i >= 0){
  //for(Document doc : result1){
    for(i = beacons101x.size()-2; i >= 0; i--){
     float x1 = beacons101x.get(i);
     float y1 = beacons101y.get(i);
     
     fill(255,0,255);
     beaconsdata(x1,y1);
     //drawline(x1,y1,beacons101x[i-1],beacons101y[i-1]);
     
          drawline(x1,y1,beacons101x.get(i+1),beacons101y.get(i+1));

     
     println(i);
     println(x1);
     println(y1);
    }
  //}
  }
  
  nya.endTransform();
} 


void beaconsdata(float x, float y){
  float x_1, y_1, x1, y1;
  
  x_1 = x * -22.5;
  y_1 = y * 21.739;
  
  x1 = 90 + x_1;
  y1 = -75 + y_1;
  
  
  translate(x1,y1,0);
  sphere(4);
  translate(-x1,-y1,0);
}

void drawline(float a, float b,float c, float d){
  float a1, b1, c1, d1;
  float a2, b2, c2, d2;
  
  a1 = a * -22.5;
  b1 = b * 21.739;
  
  c1 = c * -22.5;
  d1 = d * 21.739;
  
  a2 = 90 + a1;
  b2 = -75 + b1;
  
  c2 = 90 + c1;
  d2 = -75 + d1;
  
  line(a2, b2, c2, d2);
}