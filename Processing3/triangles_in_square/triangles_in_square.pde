int counter = 0;
int stop = 2000;
void setup(){
  size(244,66);
  background(255);
  stroke(255);
  noStroke();
}

void draw(){
  
  float x = random(0,width);
  float y = random(0,height);
  
  PVector p2 = pointCloseTo(x,y,height/2);
  PVector p3 = pointCloseTo(x,y,height/2);
  
  int r = (int)random(100,255);
  int b = (int)random(150,255);
  
  fill(r,0,b,200);
  
  triangle(x,y,p2.x,p2.y,p3.x,p3.y);
  
  counter += 1;
  if(counter == stop){
   noLoop(); 
  }
}

PVector pointCloseTo(float _x, float _y, int _dist){
  float newX = min(max(0,random(_x - _dist, _x + _dist)),width);
  float newY = min(max(0,random(_y - _dist, _y + _dist)),height);
  
  return new PVector(newX,newY);
}