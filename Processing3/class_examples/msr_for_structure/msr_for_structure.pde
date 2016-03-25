void setup() {
  size(600, 400);
  background(0);
}

void draw() {
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 6; j++) {
      float r = map(i,1,10,50,255);
      float b = map(j,1,5,50,255);
      fill(r,0,b);
      rect(i*50,j*50,40,40);
    }
  }  
  noLoop();
}