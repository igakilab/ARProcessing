import processing.opengl.*;

void setup(){
  size(400,400,OPENGL);
}

void draw(){
  background(0);
  translate(200,200);
  fill(100);
  sphere(20);
}