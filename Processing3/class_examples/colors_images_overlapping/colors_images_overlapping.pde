PImage r,g,b;
void setup() {
  size(550, 500);
  pixelDensity(2);

  r = loadImage("r.png");
  g = loadImage("g.png");
  b = loadImage("b.png");
}

void draw() {
  background(0);

  image(r,100,100);
  image(g,width-g.width-100,100);
  image(b,width/2-g.width/2,height-g.height-50);
}