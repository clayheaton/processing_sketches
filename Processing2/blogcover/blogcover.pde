float yoff = 0.0;
float xpos = 0.0;

int counter = 0;

void setup() {
  size(1150, 475);
  background(14, 25, 64);
}

void draw() {

  if (counter < 200) {
    fill(51,104,198,random(20));
    noStroke();
    int szz = int(random(5,500));
    ellipse(random(width),random(height),szz,szz);

  } else {
    // fill(0, 0, random(0, 200));
    fill(255,255,255,random(20));
    noStroke();
    int sz = int(random(5, 50));
    yoff = yoff + 0.01;
    xpos += 5;
    float n = noise(yoff) * height;
    ellipse(xpos, n, 15, 15);
    if(xpos > width){
     xpos = 0; 
    }
  }
  counter += 1;
}

