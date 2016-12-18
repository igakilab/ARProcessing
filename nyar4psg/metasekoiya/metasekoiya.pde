import processing.opengl.*;
import com.jogamp.opengl.GL2.*;

import jp.nyatla.kGLModel.*;
import jp.nyatla.kGLModel.contentprovider.*;

KGLModelData model_data;
ContentProvider content_provider;

void setup(){
  size(400,300,OPENGL);
  
  content_provider = new LocalContentProvider(this, "C:\3Dobj\\ensui.mqo");
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
  PGL gl = pgl.beginPGL();
  model_data = KGLModelData.createGLModelps(
                  this, gl, null,
                  this.content_provider,1.0,
                  KGLExtensionCheck.IsExtensionSupported( gl, "PGL_ARB_vertex_buffer_object"),
                  true);
  pgl.endPGL();
}

void draw(){
  background(128);
  
  camera (mouseX, mouseY, 200, width/2.0, height/2.0, 0, 0, 1, 0);
  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
  GL gl = pgl.beginGL();
  
    gl.glTexEnvf(GL.GL_TEXTURE_ENV, GL.GL_TEXTURE_ENV_MODE, GL.GL_MODULATE);
    gl.glEnable(GL.GL_CULL_FACE);
    gl.glCullFace(GL.GL_FRONT);
    
    
    mySetLight(gl, 0, 0, 1000);
    
    gl.glTranslatef(width/2, 0.8*height, 0);
    gl.glRotatef(180, 1, 0, 0);
    
    model_data.draw();
    
  pgl.endGL();
}



void mySetLight(GL gl, float x, float y, float z){
  float[] light_diffuse = {0.2, 0.2, 0.2, 1.0};
  float[] light_specular = {0.3, 0.3, 0.3, 1.0};
  float[] light_ambient = {0.3, 0.3, 0.3, 1.0};
  float[] light_position = {x, y, z, 0.0};
  
  gl.glLightfv(gl.GL_LIGHTO, gl.GL_DIFFUSE, light_diffuse, 0);
  gl.glLightfv(gl.GL_LIGHTO, gl.GL_SPECULAR, light_specular, 0);
  gl.glLightfv(gl.GL_LIGHTO, gl.GL_AMBIENT, light_ambient, 0);
  gl.glLightfv(gl.GL_LIGHTO, gl.GL_POSITION, light_position, 0);
  gl.glShadeModel(gl.GL_SMOOTH);
  gl.glEnable(gl.GL_LIGHTO);
  gl.glEnable(gl.GL_LIGHTING);
}