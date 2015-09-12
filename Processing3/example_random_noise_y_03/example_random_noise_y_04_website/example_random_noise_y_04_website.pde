int x,y;

// Example from here:
// https://processing.org/reference/noise_.html

// Adjust this for jagged/smooth.
// Lower values are more smooth.
float noiseScale = 0.02;

void setup(){
 size(800,600);
 background(255);

}

void draw() {
  background(255);
  for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, 
                            mouseY*noiseScale);

    int blueChannel = (int)map(noiseVal,0,1,0,255);
    stroke(200,0,blueChannel);
    line(x, mouseY+noiseVal*80, x, height);
  }
}