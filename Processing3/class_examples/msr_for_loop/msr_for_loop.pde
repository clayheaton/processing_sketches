
void setup() {
  size(600, 400);
  background(0);
}

void draw() {
  
  for (int i = 0; i < 1000; i = i + 100) {
    
    float x = random(0, width);
    float y = random(0, height);
    float r = random(0, 255);
    float g = random(0, 255);
    float b = random(0, 255);
    float a = random(20,70);
    
    println("my x value: " + x + " my y value: " + y);
    
    fill(r, g, b, a);
    noStroke();
    rect(x, y, 50, 50);
    
  }
}