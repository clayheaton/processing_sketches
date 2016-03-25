int red_value   = 209;
int green_value = 100;
int blue_value  = 255;
void setup() {
  size(550, 500);
  noStroke(); 
}

void draw() {
  blendMode(ADD);
  background(0);
  fill(red_value,0,0);
  ellipse(200,200,250,250);
  
  fill(0,green_value,0);
  ellipse(width-200,200,250,250);
  
  fill(0,0,blue_value);
  ellipse(width/2,height-175,250,250);
}