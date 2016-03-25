PImage photo;

void setup(){
 size(500,500);
 background(0);
 photo = loadImage("msr2.png");
 noStroke();
}

void draw(){
  background(0);
  //image(photo,0,0,500,500);
  
  for (int i = 0; i < 10000; i++){
   int x = (int)random(0,width);
   int y = (int)random(0,height);
   color c = photo.get(x,y);
   strokeWeight(4);
   stroke(c);
   
   PVector p = new PVector(x,y);
   PVector m = new PVector(mouseX,mouseY);
   PVector n;
   
   n = PVector.lerp(p,m,0.1);
   
   line(x,y,n.x,n.y);
   fill(c);
   // ellipse(x,y,10,10);
   // triangle(x,y,x+9,y,x+5,y+9);
  }
  
  //noLoop();
}