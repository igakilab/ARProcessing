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
boolean aa = true;
int i= 0;
PImage img;
FindIterable<Document> result1, result2, result3;
Document latest1, latest2, latest3;
float x1 = 0.0,y1 = 0.0,x2 = 0.0,y2 = 0.0,x3 = 0.0,y3 = 0.0;

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
  
  img = loadImage("lab.PNG");
        
  FindIterable<Document> result1 = collection.find(Filters.eq("minor" ,101)).sort(Sorts.descending("date")).limit(30);
  FindIterable<Document> result2 = collection.find(Filters.eq("minor" ,102)).sort(Sorts.descending("date")).limit(30);
  FindIterable<Document> result3 = collection.find(Filters.eq("minor" ,103)).sort(Sorts.descending("date")).limit(30);

  latest1 = result1.first();
  latest2 = result2.first();
  latest3 = result3.first();

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
  
  if( aa ){
    
    beginShape(QUAD);
    textureMode(NORMAL);
    texture(img);
    vertex(-100,-125,1,1);
    vertex(-100,125,1,0);
    vertex(100,125,0,0);
    vertex(100,-125,0,1);
    endShape();
    
    x1 = latest1.getDouble("x").floatValue();
    y1 = latest1.getDouble("y").floatValue();
    
    x2 = latest2.getDouble("x").floatValue();
    y2 = latest2.getDouble("y").floatValue();
    
    x3 = latest3.getDouble("x").floatValue();
    y3 = latest3.getDouble("y").floatValue();
    
    beaconsdata(x1,y1);
    
    beaconsdata(x2,y2);
    
    beaconsdata(x3,y3);
    
    
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
  