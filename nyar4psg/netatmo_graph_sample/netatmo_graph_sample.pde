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

float[] tem = new float[145];
long[] time = new long[145];
FindIterable<Document> result, result_ascend;
Document latest, oldest;
int i = 0;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
float dataMin, dataMax;
long timeMin, timeMax;

  int count = 0;

MongoClient mongoClient = new MongoClient("150.89.234.253", 27018);

MongoDatabase database = mongoClient.getDatabase("test");

MongoCollection<Document> collection = database.getCollection("netatmotest");


void setup(){
  size(640, 480);
  frameRate(10);
        
  FindIterable<Document> result = collection.find().sort(Sorts.descending("date")).limit(145);
  latest = result.first();
  
  i = tem.length-1;
  for(Document doc : result){
    float a = doc.getDouble("tem").floatValue();
    tem[i] = a;
    
    Date d = doc.getDate("date");
    long b = d.getTime();
    println("TIME[" + i + "]: " + b);
    time[i] = b;
    i--;
    count++;
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
  dataMax = 0;
  for(i = 0; i < tem.length; i++){
    if ( dataMax < tem[i]){
      dataMax = tem[i];
    }
  }
}


void draw() {
  background(224);
  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);
  
  drawTitle();
  
  drawAxisLabels();
  drawTimeLabels();
  drawVolumeLabels();
  
  drawDataPoints();
  
  
  println(count);
  
  DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  String timeMinStr = df.format(timeMin);
  String timeMaxStr = df.format(timeMax);
  
  text(""+timeMinStr+"~"+timeMaxStr, (plotX1+plotX2)/2, plotY1-40);
}

//タイトルの表示
void drawTitle(){
  fill(0);
  textSize(20);
  textAlign(LEFT);
  text("Temperature History", plotX1,plotY1-10);
}

//グラフのそれぞれの軸のラベルの表示
void drawAxisLabels(){
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  text("Temperature", labelX, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Time", (plotX1+plotX2)/2, labelY);
}

//グラフの横軸の表示
void drawTimeLabels() {
  fill(0);
  textSize(10);
  textAlign(CENTER);
  
  stroke(224);
  strokeWeight(1);
  
  for(int i = 0; i < tem.length; i++){
    float x = map(tem[i], timeMin, timeMax, plotX2, plotX2);
    if(i == 0 || (i+1 % 5 == 0)){  
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
 
  for (float v = dataMin; v <= 35; v += 5) {
    if (v % 5 == 0) {
      float y = map(v, dataMin, 35, plotY2, plotY1);  
      if (v % 10 == 0) {
        if (v == dataMin) {
          textAlign(RIGHT);
        } else if (v == 35) {
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

//指定した配列をプロットする
void drawDataPoints() {
  beginShape();
  float x0 = map(time[0], timeMin, timeMax, plotX1, plotX2);
  float y0 = map(tem[0], dataMin, 35, plotY2, plotY1);
  for (int row = 1; row < tem.length; row++) {
      if(row == 1){
        float x1 = map(time[row], timeMin, timeMax, plotX1, plotX2);
        float y1 = map(tem[row], dataMin, 35, plotY2, plotY1);
        
        ellipse(x1,y1,4,4);
        line(x0,y0,x1,y1);
      }
      float x = map(time[row], timeMin, timeMax, plotX1, plotX2);
      float y = map(tem[row], dataMin, 35, plotY2, plotY1);
      
      float x1 = map(time[row-1], timeMin, timeMax, plotX1, plotX2);
      float y1 = map(tem[row-1], dataMin, 35, plotY2, plotY1);
      
      ellipse(x,y,4,4);
      line(x1,y1,x,y);
      println(row + ":" + tem[row] + "(" + x + ", " + y + ")");
  }
  endShape();
}