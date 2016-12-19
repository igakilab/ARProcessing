import jp.nyatla.nyar4psg.*;
import jp.nyatla.nyar4psg.utils.*;

import processing.video.*;

PImage img;

Capture cam;
MultiMarker nya;

void setup(){
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addNyIdMarker(0, 80);
  cam.start();
  
  img = loadImage("lab.PNG");
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
  translate(0,0,20);
  
  beginShape(QUAD);
  textureMode(NORMAL);
  texture(img);
  vertex(-100,-125,1,1);
  vertex(-100,125,1,0);
  vertex(100,125,0,0);
  vertex(100,-125,0,1);
  endShape();
    
  nya.endTransform();
}   