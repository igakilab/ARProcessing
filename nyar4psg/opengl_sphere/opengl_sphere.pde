import processing.opengl.*;

void setup(){
  size(465,465,OPENGL);
  sphereDetail(40);
  
  translate(width/2,height/2,0);
  
  sphere(100);
}