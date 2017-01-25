import controlP5.*;

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
boolean aa = true,bb = true,cc = false;
Capture cam;
MultiMarker nya;
FindIterable<Document> result;
int i, MONEY;

Calendar cal = Calendar.getInstance();

ArrayList<Integer> money = new ArrayList<Integer>();

MongoClient mongoClient = new MongoClient("150.89.234.253", 27017);

MongoDatabase database = mongoClient.getDatabase("labshop");

MongoCollection<Document> collection = database.getCollection("shop");

void setup(){
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addNyIdMarker(0, 80);
  cam.start();
  
  cal.set(year(),month()-1,day(), 0,0,0);
  Date d1 = cal.getTime();

  FindIterable<Document> result = collection.find(Filters.gte("date",d1)).sort(Sorts.descending("date"));


  i = 0;
  for(Document doc : result){
    Integer a = doc.getInteger("money");
    money.add(a);
  }
  
  for(i = 0; i < money.size();i++){
    MONEY = money.get(i);
  }
  
  Button = new ControlP5(this);
  Button.addButton("money")
        .setValue(0)
        .setPosition(10,10)
        .setSize(50,20);


  Button.addButton("koike")
        .setValue(0)
        .setPosition(50,10)
        .setSize(50,20);


}

void draw(){
  if (cam.available() !=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  
  if ((!nya.isExist(0))) {
    return;
  }
  
  nya.beginTransform(0);
  fill(0,0,225);
  translate(0,0,20);
  
  if(aa){
    if(bb){
    
  
    Button.addButton("name")
          .setValue(0)
          .setPosition(30,30)
          .setSize(50,10);
          
    println(MONEY);
    println("a");
    fill(255,0,0);
    rect(35,35,65,15);
    }
  //rect(0,0,10,10);
  }
  if(cc){
    
    fill(0,0,255);
    rect(35,35,65,15);
  }
  
  nya.endTransform();
}

void money(){
  aa = !aa;
}

void name(){
 bb = !bb;
}

void koike(){
  cc = !cc;
}