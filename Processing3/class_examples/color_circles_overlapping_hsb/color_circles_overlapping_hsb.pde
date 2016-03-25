int x,y,dim;

void setup() {
  size(900, 250);
  noStroke();
  dim = 100;
  
  blendMode(BLEND);
  blendMode(ADD);
}

void draw() {
  background(0);
  
  x = 100;
  y = 100;
  
  fill(0,100,100,100);
  ellipse(x,y,dim,dim);
  
  fill(120,100,100,100);
  ellipse(x+dim/2,y,dim,dim);
  
  fill(240,100,100,100);
  ellipse(x+dim/4,y+dim/2,dim,dim);
  
  fill(255);
  rect(250,0,250,height);
  
  x += 250;

  fill(0,100,100,100);
  ellipse(x,y,dim,dim);
  
  fill(120,100,100,100);
  ellipse(x+dim/2,y,dim,dim);
  
  fill(240,100,100,100);
  ellipse(x+dim/4,y+dim/2,dim,dim);
  
  
}