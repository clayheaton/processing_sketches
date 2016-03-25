PImage anse;

float noiseDetail = 0.05;

void setup() {
  size(640, 425); 
  anse = loadImage("anse.jpg");

  background(255);
  noStroke();
}

void draw() {
  // Pointillism
  int x = (int)random(width+1);
  int y = (int)random(height+1);
  
  float n = noise(x*noiseDetail,y);
  
  // Get the color of the pixel at x,y
  color p = anse.get(x,y);
  
  // Extract the color channel info
  float red   = red(p);
  float green = green(p);
  
  fill(red,green,255*n);
  
  ellipse(x,y,10,10);
}