int bufferScale = 20;

void setup(){
  size(100,100);
  background(0);
}

void draw(){
  PGraphics largeBuffer = createGraphics(width*bufferScale,height*bufferScale);
  beginRecord(largeBuffer);
  largeBuffer.background(0);
  largeBuffer.scale(bufferScale);
  
  noStroke();
  fill(255,0,0);
  ellipse(75,75,50,50);
  
  largeBuffer.save("crappy_image.png");
  endRecord();
  exit();
}