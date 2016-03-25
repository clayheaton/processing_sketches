float noiseScale = 0.02;

void setup(){
 size(640,480); 
 background(255);
}

void draw() {
  background(255);
  for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, 
                            mouseY*noiseScale);
    stroke(noiseVal*100,50,noiseVal*255);
    line(x, mouseY+noiseVal*80, x, height);
  }
}