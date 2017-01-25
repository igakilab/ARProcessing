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
boolean aa = false, bb = false,cc= false,dd=false,ee=false,ff=false,
        gg= false,hh=false,ii=false,jj=false,kk=false;
Capture cam;
MultiMarker nya;

FindIterable<Document> result1,result2,result3,result4,result5,result6;
FindIterable<Document> result7,result8,result9,result10,result11,result12;

Document latest1,latest2,latest3,latest4,latest5,latest6;
Document latest7,latest8,latest9,latest10,latest11,latest12;

int i = 0;
int id4,id5,id6,id7,id8,id9, id10,id11,id12,id13,id14,id15;

int mon1=0,mon2=0,mon3=0,mon4=0,mon5=0,mon6=0,mon7=0,mon8=0,mon9=0,mon10=0,mon11=0,mon12=0;

Calendar cal = Calendar.getInstance();
Calendar cal1 = Calendar.getInstance();

ArrayList<Integer> money1 = new ArrayList<Integer>();
ArrayList<Integer> money2 = new ArrayList<Integer>();
ArrayList<Integer> money3 = new ArrayList<Integer>();
ArrayList<Integer> money4 = new ArrayList<Integer>();
ArrayList<Integer> money5 = new ArrayList<Integer>();
ArrayList<Integer> money6 = new ArrayList<Integer>();
ArrayList<Integer> money7 = new ArrayList<Integer>();
ArrayList<Integer> money8 = new ArrayList<Integer>();
ArrayList<Integer> money9 = new ArrayList<Integer>();
ArrayList<Integer> money10 = new ArrayList<Integer>();
ArrayList<Integer> money11 = new ArrayList<Integer>();
ArrayList<Integer> money12 = new ArrayList<Integer>();

String kitaba = "kitaba",koike ="koike",ueda ="ueda";
String kiiti = "ki-ti",gida ="gida",jona ="jona";
String utida = "utida",zoe ="zoe", mitui="mitui";
String aoki = "aoki",ueyama ="ueyama",simizu ="simizu";


MongoClient mongoClient = new MongoClient("150.89.234.253", 27017);

MongoDatabase database = mongoClient.getDatabase("labshop");

MongoCollection<Document> collection = database.getCollection("shop");


void setup(){
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
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
  
  cam.start();
  
  cal.set(year(), month()-1, day(), 0, 0, 0);
  Date d1 = cal.getTime();
  
  Button = new ControlP5(this);
  Button.addButton(kitaba).setValue(0).setPosition(10,10).setSize(50,10);
  
  Button.addButton(koike).setValue(100).setPosition(70,10).setSize(50,10);
  
  Button.addButton(ueda).setValue(100).setPosition(130,10).setSize(50,10);
  
  Button.addButton(kiiti).setValue(100).setPosition(190,10).setSize(50,10);
  
  Button.addButton(gida).setValue(100).setPosition(250,10).setSize(50,10);
  
  Button.addButton(jona).setValue(100).setPosition(310,10).setSize(50,10);
  
  Button.addButton(utida).setValue(0).setPosition(10,30).setSize(50,10);
  
  Button.addButton(zoe).setValue(100).setPosition(70,30).setSize(50,10);
  
  Button.addButton(mitui).setValue(100).setPosition(130,30).setSize(50,10);
  
  Button.addButton(aoki).setValue(100).setPosition(190,30).setSize(50,10);
  
  Button.addButton(ueyama).setValue(100).setPosition(250,30).setSize(50,10);
  
  Button.addButton(simizu).setValue(100).setPosition(310,30).setSize(50,10);

  Button.addButton("130").setValue(0).setPosition(10,60).setSize(50,10);
  
  Button.addButton("100en").setValue(100).setPosition(70,60).setSize(50,10);
  
  Button.addButton("80").setValue(100).setPosition(130,60).setSize(50,10);
  
  Button.addButton("60").setValue(100).setPosition(190,60).setSize(50,10);
  
  Button.addButton("50").setValue(100).setPosition(250,60).setSize(50,10);
  
  Button.addButton("40").setValue(100).setPosition(10,80).setSize(50,10);
  
  Button.addButton("30").setValue(0).setPosition(70,80).setSize(50,10);
  
  Button.addButton("20").setValue(100).setPosition(130,80).setSize(50,10);
  
  Button.addButton("10").setValue(100).setPosition(190,80).setSize(50,10);
  
  
  FindIterable<Document> result1 = collection.find(Filters.and(Filters.eq("name",kitaba),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result2 = collection.find(Filters.and(Filters.eq("name" ,koike),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result3 = collection.find(Filters.and(Filters.eq("name" ,ueda),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result4 = collection.find(Filters.and(Filters.eq("name",kiiti),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result5 = collection.find(Filters.and(Filters.eq("name" ,gida),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result6 = collection.find(Filters.and(Filters.eq("name" ,jona),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result7 = collection.find(Filters.and(Filters.eq("name",utida),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result8 = collection.find(Filters.and(Filters.eq("name" ,zoe),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result9 = collection.find(Filters.and(Filters.eq("name" ,mitui),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result10 = collection.find(Filters.and(Filters.eq("name",aoki),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result11 = collection.find(Filters.and(Filters.eq("name" ,ueyama),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  FindIterable<Document> result12 = collection.find(Filters.and(Filters.eq("name" ,simizu),Filters.gte("date",d1))).sort(Sorts.descending("date"));
  
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
  
  i = 0;
  for(Document doc : result1){
    Integer a = doc.getInteger("money");
    money1.add(a);
  }

  for(Document doc : result2){
    Integer a = doc.getInteger("money");
    money2.add(a);
  }

  for(Document doc : result3){
    Integer a = doc.getInteger("money");
    money3.add(a);
  }

  for(Document doc : result4){
    Integer a = doc.getInteger("money");
    money4.add(a);
  }

  for(Document doc : result5){
    Integer a = doc.getInteger("money");
    money5.add(a);
  }

  for(Document doc : result6){
    Integer a = doc.getInteger("money");
    money6.add(a);
  }

  for(Document doc : result7){
    Integer a = doc.getInteger("money");
    money7.add(a);
  }

  for(Document doc : result8){
    Integer a = doc.getInteger("money");
    money8.add(a);
  }

  for(Document doc : result9){
    Integer a = doc.getInteger("money");
    money9.add(a);
  }

  for(Document doc : result10){
    Integer a = doc.getInteger("money");
    money10.add(a);
  }

  for(Document doc : result11){
    Integer a = doc.getInteger("money");
    money11.add(a);
  }

  for(Document doc : result12){
    Integer a = doc.getInteger("money");
    money12.add(a);
  }

  if(latest1 != null){
    for(i = 0; i < money1.size();i++){
      mon1 += money1.get(i);
    }
  }
  
  if(latest2 != null){
    for(i = 0; i < money1.size();i++){
      mon2 += money1.get(i);
    }
  }
  
  if(latest3 != null){
    for(i = 0; i < money1.size();i++){
      mon3 += money1.get(i);
    }
  }
  
  if(latest4 != null){
    for(i = 0; i < money1.size();i++){
      mon4 += money1.get(i);
    }
  }
  
  if(latest5 != null){
    for(i = 0; i < money1.size();i++){
      mon5 += money1.get(i);
    }
  }
  
  if(latest6 != null){
    for(i = 0; i < money1.size();i++){
      mon6 += money1.get(i);
    }
  }
  
  if(latest7 != null){
    for(i = 0; i < money1.size();i++){
      mon7 += money1.get(i);
    }
  }
  
  if(latest8 != null){
    for(i = 0; i < money1.size();i++){
      mon8 += money1.get(i);
    }
  }
  
  if(latest9 != null){
    for(i = 0; i < money1.size();i++){
      mon9 += money1.get(i);
    }
  }
  
  if(latest10 != null){
    for(i = 0; i < money1.size();i++){
      mon10 += money1.get(i);
    }
  }
  
  if(latest11 != null){
    for(i = 0; i < money1.size();i++){
      mon11 += money1.get(i);
    }
  }
  
  if(latest12 != null){
    for(i = 0; i < money1.size();i++){
      mon12 += money1.get(i);
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

  if ((!nya.isExist(id4))&&(!nya.isExist(id5))&&(!nya.isExist(id6))&&(!nya.isExist(id7))
  &&(!nya.isExist(id8))&&(!nya.isExist(id9))&&(!nya.isExist(id10))&&(!nya.isExist(id11))&&(!nya.isExist(id12))&&(!nya.isExist(id13))&&(!nya.isExist(id14))&&(!nya.isExist(id15))) {
    return;
  }
  if((nya.isExist(id4))){
    nya.beginTransform(id4); 
    fill(0,0,225);
    translate(0,0,20);
    
    if(aa){
      if(bb){
        insert(kitaba,130);
       }
      if(cc){
        insert(kitaba,100);
      }
      if(dd){
        insert(kitaba,80);
      }
      if(ee){
        insert(kitaba,60);
      }
      if(ff){
        insert(kitaba,50);
      }
      if(gg){
        insert(kitaba,40);
      }
      if(hh){
        insert(kitaba,30);
      }
      if(ii){
        insert(kitaba,20);
      }
      if(jj){
        insert(kitaba,10);
      }
        
    }
    if(kk){
      buy(mon1);
    }
  nya.endTransform();
  }
}


void insert(String a, int b){
  cal1.set(year(), month()-1, day(), hour(), minute(), second());
  Date d2 = cal1.getTime();

  Document docs = new Document();
  docs.append("date",d2);
  docs.append("name",a);
  docs.append("money",b);
  
  collection.insertOne(docs);
}

void buy(int mon1){
   fill(255,255,255);
   translate(-150, -150,-10);
   rect(0,0,300,300);
   translate(150,150,10);

   fill(255,0,0);
   text(mon1, 10,10);
  
   println(mon1);
}

void 100en(){
  aa = !aa;
}