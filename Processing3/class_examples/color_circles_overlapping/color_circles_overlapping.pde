int x, y, dim, alpha;

void setup() {
  size(1000, 500);
  noStroke();
  dim   = 100;
  alpha = 200;
}

void draw() {
  x = 100;
  y = 0;

  drawCircles(BLEND);

  x += 250;
  drawRegionalBackground(x,y,color(255));
  drawCircles(DARKEST);
  
  x += 250;
  drawCircles(LIGHTEST);
  
  x += 250;
  drawRegionalBackground(x,y,color(255,0,0));
  drawCircles(DIFFERENCE);
  
  x = 100;
  y = height/2;
  blendMode(BLEND);
  drawRegionalBackground(x,y,color(0,255,0));
  drawCircles(ADD);
  
  x += 250;
  drawRegionalBackground(x,y,color(128));
  drawCircles(SUBTRACT);
  
  x += 250;
  drawRegionalBackground(x,y,color(255));
  drawCircles(MULTIPLY);
  
  x += 250;
  drawRegionalBackground(x,y,color(0));
  drawCircles(SCREEN);
  
  noLoop();
}

void drawCircles(int blendmode) {
  blendMode(blendmode);
  fill(255, 0, 0, alpha);
  ellipse(x, y+100, dim, dim);

  fill(0, 255, 0, alpha);
  ellipse(x+dim/2, y+100, dim, dim);

  fill(0, 0, 255, alpha);
  ellipse(x+dim/4, 100+ y+dim/2 , dim, dim);
}

void drawRegionalBackground(int x, int y, color fillcolor){
  blendMode(BLEND);
  fill(fillcolor);
  rect(x - 100, y, 250, height/2);
}