PImage moon;

void setup() {
  size(500, 500); 
  background(0);
  moon = loadImage("moon.png");
}

void draw() {
  background(0);
  // tint(color(255,0,0));
  image(moon,100,100, 80, 80);
}