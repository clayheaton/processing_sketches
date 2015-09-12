int x,y;

int col;

// Adjust this for jagged/smooth.
// Lower values are more smooth.
float noiseScale = 0.005;

float colorNoiseScale   = 0.01;

void setup(){
 size(640,480);
 background(255);
 noStroke();
 fill(50,80,240);
 
 // Initial x 
 x   = 0;
 col = 255;
}

void draw() {
  
  int xPos = x % width;
  // Comment this out to see "ribbons"
  if (xPos == 0) {
   background(255); 
  }
  
  // Get a noise multiplier value
  // based on the current x position.
  float n = noise(x*noiseScale);
  
  // Color noise values
  float noisyRed   = map(noise(x * colorNoiseScale),0,1,0,255);

  // Change color based on the noise value!
  fill(noisyRed,0,0);
  
  // Draw a rectangle. Note that the
  // y-value is multiplied by our noise
  // value. This creates the smooth-random
  // positioning on the y-axis.
  y = (int)map(n,0,1,0,height);
  
  rect(xPos,y,3,100);
  
  // We're moving across the canvas from 
  // left to right, so increment x.
  x += 1;
  
}