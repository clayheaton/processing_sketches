
void setup() {
  size(1000, 1000);
  // background(color(#393A67));
  background(0);
  //background(255);
  //frameRate(20);
}

void draw() {

  float x = random(0, width);
  float y = random(0, height);

  float diam = abs(height/2 - y) + 40;

  if (diam < 50) {
    diam = abs(width/2 - x) + 40;
  }

  float r = map(x, 100, width - 100, 0, 255);
  float g = map(y, 100, height - 100, 0, 255);
  float b = map(diam, 0, height/2, 0, 255);
  
  float rot = map(x,-100,width,0,TWO_PI);

  noFill();
  float a = map(x+y,-200,width + height + 200,200,50);
  stroke(r, g, b, 50);
  strokeWeight(1);
  // ellipse(x, y, diam, diam);
  pushMatrix();
    translate(x,y);
  rotate(rot);
  rect(0,0,diam/2,diam/2);
  popMatrix();
}

