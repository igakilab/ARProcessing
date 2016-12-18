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

Capture cam;
MultiMarker nya;
FindIterable<Document> result;
Document latest;
Minim minim;  //Minim型変数であるminimの宣言
AudioPlayer player;  //サウンドデータ格納用の変数
 

MongoClient mongoClient = new MongoClient("150.89.234.253", 27018);

MongoDatabase database = mongoClient.getDatabase("test");

MongoCollection<Document> collection = database.getCollection("netatmotest");

void setup(){
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addNyIdMarker(0, 80);
  cam.start();
  
  
  minim = new Minim(this);  //初期化
  player = minim.loadFile("groove.mp3");  //groove.mp3をロードする
     
  FindIterable<Document> result = collection.find().sort(Sorts.descending("date")).limit(30);
  latest = result.first();
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
  

    fill(0,0,0);
    
    float tem  = 0.0;
    int i = 0;
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
      player.play();  //再生
    }
    if( tem < 22){
      fill(0,0,255);
      player.play();  //再生
    }
    
    text("temperature : "+tem+"℃", 0, 0);
    
    text("Humidity : "+Humidity+"%", 0, 10);
    
    text("CO2 : "+CO2+"ppm", 0, 30);
    
    text("Noise : "+Noise+"dB", 0,40);
    
    translate(-50,0, 0);
    box(10,10,Noise*6);
    
  
  
  nya.endTransform();
} 