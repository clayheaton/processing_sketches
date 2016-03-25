void setup(){
  size(800,600);
  background(0);
}

void draw() {
  int redChannel  = (int)map(mouseX,0,width,0,255);
  int blueChannel = (int)map(mouseY,0,height,0,255);
  background(redChannel,0,blueChannel);
  
  int greenChannel = (int)map(redChannel + blueChannel,0,255*2,255,0);
  int alphaChannel = (int)map(greenChannel,0,255,0,255);
  fill(0,greenChannel,0,alphaChannel);
  rect(300,200,200,200);
}