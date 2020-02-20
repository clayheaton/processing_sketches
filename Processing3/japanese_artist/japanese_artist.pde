// https://note.mu/outburst/n/n2d5f4dc2c675

void setup() {
 size(900, 900);
 //pixelDensity(2);
 noLoop();
}

void draw() {
 background(#ffffff);

 ArrayList<PVector> quads = new ArrayList<PVector>();
 quads.add(new PVector(10, 10, width-20));
 int c = int(random(5, 50));
 for (int i = 0; i < c; i++) {
   int ind = int(random(quads.size()));
   PVector q = quads.get(ind);
   float hs = q.z/2;
   float ss = q.z/3;
   float mins = 30;

   if (ss < mins) continue;

   if (random(1) > 0.5) {
     quads.add(new PVector(q.x, q.y, hs));
     quads.add(new PVector(q.x+hs, q.y, hs));
     quads.add(new PVector(q.x+hs, q.y+hs, hs));
     quads.add(new PVector(q.x, q.y+hs, hs));
     quads.remove(ind);
   } else {
     for (int j = 0; j < 3; j ++) {
       quads.add(new PVector(q.x + ss*j, q.y, ss));
       quads.add(new PVector(q.x + ss*j, q.y + ss, ss));
       quads.add(new PVector(q.x + ss*j, q.y + ss*2, ss));
     }
     quads.remove(ind);
   }
 }

 for (int i = 0; i < quads.size(); i ++) {
   PVector q = quads.get(i);
   float x = q.x;
   float y = q.y;
   float s = q.z;
   
   strokeWeight(2);
   stroke(#ffffff);
   fill(getCol());
   rect(x, y, s, s, 20);
   
   stroke(0);
   strokeWeight(3);
   fill(getCol());
   rndForm(x, y, s);
 }

 tile();
}

void rndForm(float x, float y, float s) {
 int rnd = (int)random(6);
 float hs = s/2;
 float sw = s*0.01;

 strokeWeight(sw);

 if (rnd == 0) {
   float ss = s * 0.9;
   
   circle(x + hs, y + hs, hs);
   circle(x + hs, y + hs, hs * 0.35);
   line(x + hs, y + ss, x + hs, y + s - ss);
   line(x + ss, y + hs, x + s - ss, y + hs);
   
   push();
   translate(x + hs, y + hs);
   for (int i = 0; i < 4; i ++) {
     rotate(i*HALF_PI);
     line(ss*0.45, s*0.05, ss*0.45, -s*0.05);
   }
   pop();
 }

 if (rnd == 1) {
   float  ss = s *0.8;
   
   rect(x+ss*0.125, y+ss*0.125, ss, ss, 20);
   
   int c = 10;
   float w = ss/c;
   float xx = x + ss*0.125;
   float yy = y + ss*0.125;
   
   fill(0);
   for (int i=1; i<c; i++) {
     for (int j=1; j<c; j++) {
       noStroke();
       circle(xx+i*w, yy+j*w, s*0.01);
     }
   }
 }

 if (rnd == 2) {
   push();
   translate(x+hs, y+hs);
   for (int i=0; i<5; i++) {
     beginShape();
     fill(getCol());
     for (float a = 0; a < TWO_PI + PI; a += radians(40)) {
       float r = map(i, 0, 4, s*0.45, s * 0.1);
       float x1 = r * cos(a);
       float y1 = r * sin(a);
       float x2 = r * 0.5 * cos(a + radians(20));
       float y2 = r * 0.5 * sin(a + radians(20));
       vertex(x1, y1);
       vertex(x2, y2);
     }
     endShape();
     noStroke();
   }
   pop();
 }

 if (rnd == 3) {
   noStroke();
   fill(0, 60);
   ellipse(x + hs, y + hs + s*0.2, s*0.45, s*0.15);

   fill(getCol());
   stroke(0);
   circle(x + hs, y + hs, s*0.4);
   noStroke();
   fill(255, 150);
   circle(x + hs*0.9, y + hs*0.9, s*0.1);
 }

 if (rnd == 4) {
   circle(x+hs, y+hs, s*0.9);
   fill(getCol());
   circle(x+hs, y+hs, s*0.6);
 }
 
 if (rnd == 5) {
   triangle(x+s*0.5, y+s*0.3, x+s*0.9, y+s*0.7, x+s*0.2, y+s*0.8);
   fill(getCol());
   circle(x+s*0.5, y+s*0.3, s *0.4);
   fill(getCol());
   circle(x+s*0.5, y+s*0.3, s *0.2);
 }
}

void tile() {
 int count = 450;
 float w = width/count;
 
 noStroke();

 for (int j = 0; j < count; j++) {
   for (int i = 0; i < count; i++) {
     fill(getCol(), 18);
     square(i*w, j*w, w);
   }
 }
}

void mousePressed() {
 redraw();
}

void keyPressed() {
 if (key == 's')saveFrame("####.png");
}

int[] colors = {#e6c229, #f17105, #d11149, #6610f2, #24c7f4, #00A878};

int getCol() {
 return colors[(int)random(colors.length)];
}
