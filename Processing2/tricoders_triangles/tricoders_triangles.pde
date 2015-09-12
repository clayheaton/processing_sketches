int factor    = 50;
int triangles = 40000;

void setup() {
  size(250, 250);
}

void draw() {
  // Initial triangle
  background(255);

  Triangle t = new Triangle(125, 40, 180, 190, 70, 190, color(255));
  t.display();

  int remaining = triangles;

  while (remaining > 0) {
    // Pick 3 points
    PVector a = new PVector(random(width), random(height));
    
    int bxdir = 1;
    if(random(100) > 50) { bxdir = -1; }
    
    int bydir = 1;
    if(random(100) > 50) { bydir = -1; }
    
    int cxdir = 1;
    if(random(100) > 50) { cxdir = -1; }
    
    int cydir = 1;
    if(random(100) > 50) { cydir = -1; }
    
    PVector b = new PVector(a.x + random(width/factor) * bxdir, a.y + random(height/factor) * bydir);
    PVector c = new PVector(a.x + random(width/factor) * cxdir, a.y + random(height/factor) * cydir);

    color col = color(random(255), random(100), random(255), random(255));

    if (t.contains(a.x, a.y) || t.contains(b.x, b.y) || t.contains(c.x, c.y)) {

      boolean ok = true;

      Triangle tr = new Triangle(a.x, a.y, b.x, b.y, c.x, c.y, col);
      tr.display();

      remaining -=1;
    }
  }

}

