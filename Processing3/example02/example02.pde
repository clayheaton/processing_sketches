void setup() {
   size(1000,240); 
   background(255);
   noStroke();
   frameRate(15);
}

void draw(){
   for(int i = 0; i < 3; i ++){
      color c = color(random(100,255), random(100,255), random(100,255),50);
      fill(c);
      int diameter = (int)random(40);
      ellipse(random(width),random(height),diameter,diameter);
   }
}