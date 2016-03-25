int x,y;

int r,g,b;

// Adjust this for jagged/smooth.
// Lower values are more smooth.
float noiseScale = 0.005;

float redNoiseScale   = 0.01;
float greenNoiseScale = 0.02;
float blueNoiseScale  = 0.05;

void setup(){
 size(640,480);
 background(255);
 noStroke();
 fill(50,80,240);
 
 // Initial x and y positions
 x = 0;
 
 r = 255;
 g = 255;
 b = 255;
}

void draw() {
 
  int xPos = x % width;
  
  if (xPos == 0){
   background(255); 
  }
  
  // Get a noise multiplier value
  // based on the current x position.
  float n = noise(x*noiseScale);
  
  // Color noise values
  float noisyRed   = map(noise(x * redNoiseScale),  0,1,0,255);
  float noisyGreen = map(noise(x * greenNoiseScale),0,1,0,255);
  float noisyBlue  = map(noise(x * blueNoiseScale), 0,1,0,255);
  
  // Change color based on the noise value!
  fill(noisyRed,noisyGreen,noisyBlue);
  
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