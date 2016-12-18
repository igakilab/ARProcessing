import processing.opengl.*;

void setup() {
  size(400,400,OPENGL);
  smooth();
  frameRate(30);
}

void draw() {
  background(0);
  translate(200,200);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  rotateX(map(mouseY,0,height,0,PI));
  rotateY(map(mouseX,0,width,0,PI));
  fill(0,0,255);
  box(150);
}