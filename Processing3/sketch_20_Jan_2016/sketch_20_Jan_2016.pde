
int diam  = 20;
int balls = 100;
ArrayList<PVector> dots;
PVector center;

void setup() {
  size(300, 600); 
  background(0);

  dots = new ArrayList<PVector>();

  // Initialize the list
  center = new PVector(width/2.0, height/2.0);
  dots.add(center);
  fill(255);
  noStroke();
}

void draw() {
  background(0);

  if (dots.size() < balls) {
    PVector last = dots.get(dots.size() - 1);
    PVector next = pointFromPoint(last);
    dots.add(next);
    println("added");
  } else {
    PVector last = dots.get(dots.size() - 1);
    PVector next = pointFromPoint(last);
    dots.add(next);
    dots.remove(0);
  }

  for (int i = 0; i < dots.size(); i++) {
    PVector p = dots.get(i);
    if(i < dots.size()/2){
      fill(255,0,0);
    } else {
      fill(0,0,255);
    }
    ellipse(p.x, p.y, diam, diam);
  }
}

PVector pointFromPoint(PVector lastPt) {
  float a = random(0, TWO_PI);
  float ptX = lastPt.x + sin(a)*diam;
  float ptY = lastPt.y + cos(a)*diam;

  while (ptX < diam/2.0 || ptX > width-(diam/2.0) || ptY < diam/2.0 || ptY > height-(diam/2.0)) {
    a = random(0, TWO_PI);
    ptX = lastPt.x + sin(a)*diam;
    ptY = lastPt.y + cos(a)*diam;
  }

  PVector pv = new PVector(ptX, ptY);
  //boolean ok = pointIsOK(pv);
  //println("made point");
  //while (!ok) {
  // ptX = random(diam/2.0,width-(diam/2.0));
  // ptY = random(diam/2.0,height-(diam/2.0));
  // pv  = new PVector(ptX, ptY);
  // ok  = pointIsOK(pv);
  //}
  return pv;
}

boolean pointIsOK(PVector candidate) {
  for (PVector p : dots) {
    if (PVector.dist(p, candidate) < diam) {
      return false;
    }
  }
  return true;
}