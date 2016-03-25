import processing.video.*;

Capture video;

void setup(){
 size(800,600);
 video = new Capture(this, 320,240);
 video.start();
 background(255);
}

void draw(){
  pushMatrix();
  translate(mouseX,mouseY);
  rotate(map(mouseX,0,width,0,radians(360)));
  image(video, -video.width/2, -video.height/2);
  popMatrix();
}

void captureEvent(Capture video){
 video.read(); 
 video.filter(POSTERIZE,2);
 // video.filter(INVERT);
 // video.filter(THRESHOLD);
}