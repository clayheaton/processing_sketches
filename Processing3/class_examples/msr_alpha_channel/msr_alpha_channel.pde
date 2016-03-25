/* Move your mouse from left to right 
 to adjust the level of the alpha channel */
 
int red_value   = 0;
int green_value = 0;
int blue_value  = 255;
int alpha_value = 255;

void setup() {
  size(550, 500);
  noStroke(); 
}

void draw() {
  background(255);
  
  alpha_value = (int)map(mouseX,0,width,0,255);
  
  fill(red_value,green_value,blue_value,alpha_value);
  ellipse(200,200,250,250);
  ellipse(width-200,200,250,250);
  ellipse(width/2,height-175,250,250);
}