
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

FindIterable<Document> result, result_ascend;
Document latest, oldest;
int i = 0;
int year, month, day, hour, minute;

Calendar cal = Calendar.getInstance();
Calendar cal2 = Calendar.getInstance();


float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
float dataMin, dataMax;
long timeMin, timeMax;

ArrayList<Long> Time = new ArrayList<Long>();
ArrayList<Float> Tem = new ArrayList<Float>();

MongoClient mongoClient = new MongoClient("150.89.234.253", 27018);

MongoDatabase database = mongoClient.getDatabase("test");

MongoCollection<Document> collection = database.getCollection("netatmotest");


void setup(){
  size(640, 480);
  frameRate(10);
  
  cal.set(year, month, day);
  Date d = cal.getTime();
  
  cal.set(year, month, day, hour, minute);
  Date d2 = cal.getTime();

        
  FindIterable<Document> result = collection.find(Filters.and(Filters.gte("date",d), Filters.lte("date",d2))).sort(Sorts.descending("date"));
  FindIterable<Document> result_ascend = collection.find().sort(Sorts.descending("date")).sort(Sorts.ascending("date"));
  latest = result.first();
  oldest = result_ascend.first();
  
  
  for(Document doc : result){
    float a = doc.getDouble("tem").floatValue();
    Tem.add(a);
  
    Date c = doc.getDate("date");
    long b = c.getTime();  
    Time.add(b);
  }
  
  plotX1 = 120; 
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  
  Date timemax = latest.getDate("date");
  timeMax = timemax.getTime();
  Date timemin = oldest.getDate("date");
  timeMin = timemin.getTime();
  
  dataMin = 0;
  dataMax = 0;
  for(i = 0; i < Tem.size(); i++){
    if ( dataMax < Tem.get(i)){
      dataMax = Tem.get(i);
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
  
  println(timeMin);
  println(timeMax);
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
  
  for(int i = 0; i < Tem.size(); i++){
    if(i == 0 || (i+1 % 5 == 0)){
      float x = map(Tem.get(i), timeMin, timeMax, plotX2, plotX2);
      text(Time.get(i), x, plotY2 + textAscent() + 10);
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
  for (int row = 0; row < Tem.size(); row++) {
      
      float x = map(Time.get(row), timeMin, timeMax, plotX1, plotX2);
      float y = map(Tem.get(row), dataMin, 35, plotY2, plotY1);
      ellipse(x,y,4,4);
      vertex(x,y);
      println(Tem.get(row));
  }
  endShape();
}