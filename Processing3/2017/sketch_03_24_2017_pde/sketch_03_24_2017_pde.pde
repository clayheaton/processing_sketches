import gifAnimation.*;

GifMaker gifExport;

float a1, a2, a3;
float r1, r2, r3;
Thing t1, t2, t3;
float genrad = 15;
PVector center;

void setup() {
  size(200, 200);

  background(240, 104, 73);
  stroke(255);
  strokeWeight(2);
  fill(255);
  noStroke();

  a1 = 0;
  a2 = PI / 2;
  a3 = (TWO_PI * 2) / 3;

  r1 = 25;
  r2 = 100;
  r3 = 175;

  center = new PVector(width/2, height/2);

  t1 = new Thing(a1, r1);
  t2 = new Thing(a2, r2);
  t3 = new Thing(a3, r3);
  
  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(1);
  //gifExport.setTransparent(255, 255, 255);
}

void draw() {
  background(240, 104, 73);

  //t1.display();
  //t2.display();
  //t3.display();
  
  //line(t1.pos.x,t1.pos.y,t2.pos.x,t2.pos.y);
  //line(t1.pos.x,t1.pos.y,t3.pos.x,t3.pos.y);
  //line(t2.pos.x,t2.pos.y,t3.pos.x,t3.pos.y);
  
  ellipse(t1.pos.x,t1.pos.y,genrad,genrad);
  ellipse(t2.pos.x,t2.pos.y,genrad,genrad);
  ellipse(t3.pos.x,t3.pos.y,genrad,genrad);
  
  float t1t2x = lerp(t1.pos.x,t2.pos.x,0.5);
  float t1t2y = lerp(t1.pos.y,t2.pos.y,0.5);
  float t1t3x = lerp(t1.pos.x,t3.pos.x,0.5);
  float t1t3y = lerp(t1.pos.y,t3.pos.y,0.5);
  float t2t3x = lerp(t2.pos.x,t3.pos.x,0.5);
  float t2t3y = lerp(t2.pos.y,t3.pos.y,0.5);
  
  //line(t1t2x,t1t2y,t1t3x,t1t3y);
  //line(t1t2x,t1t2y,t2t3x,t2t3y);
  //line(t2t3x,t2t3y,t1t3x,t1t3y);
  
  ellipse(t1t2x,t1t2y,genrad,genrad);
  ellipse(t2t3x,t2t3y,genrad,genrad);
  ellipse(t1t3x,t1t3y,genrad,genrad);
  

  a1 += 0.03;
  a2 -= 0.03;
  a3 += 0.03;
  
  t1.updatePos(a1,r1);
  t2.updatePos(a2,r2);
  t3.updatePos(a3,r3);
  
    if (TWO_PI*2 - a1 > 0.02) {
    gifExport.addFrame();
  } else {
    gifExport.finish();
    noLoop();
  }
}

class Thing {
  float angle, radius;
  PVector pos;
  Thing(float _angle, float _radius) {
    angle  = _angle;
    radius = _radius;
    pos    = new PVector();
    calcPos();
  }

  void updatePos(float _a, float _r) {
    this.angle  = _a;
    this.radius = _r;
    calcPos();
  }
    

  void calcPos() {
    pos.x  = center.x + cos(this.angle) * radius;
    pos.y  = center.y + sin(this.angle) * radius;
  }

  void display() {
    ellipse(pos.x, pos.y, 20, 20);
  }
}