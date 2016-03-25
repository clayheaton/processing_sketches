PImage photo;

void setup(){
 size(500,500);
 background(0);
 photo = loadImage("msr2.png");
 noStroke();
}

void draw(){
  background(0);
  
  for (int i = 0; i < 10000; i++){
   int x = (int)random(0,width);
   int y = (int)random(0,height);
   color c = photo.get(x,y);
   strokeWeight(4);
   stroke(c);
   
   PVector p = new PVector(x,y);
   
   drawFromPointTowardsMouse(p,15);

  }
  
  //noLoop();
}

void drawFromPointTowardsMouse(PVector _pt, float _length){
  // Store the mouse position
  PVector mouse = new PVector(mouseX,mouseY);
  
  // Subtract the point of interest vector from the mouse position.
  // This gives us the vector between the two
  mouse.sub(_pt);
  
  // Figure out the magnitude of the vector connecting the point
  // to the mouse
  float distToMouse = mouse.mag();
  
  // Make this a "unit vector" that we can then extend to the 
  // length of choice.
  mouse.normalize();
  
  // Make the "unit vector" each the length specified, or if it
  // is shorter, the length of the vector connecting the point
  // to the mouse.
  mouse.mult(min(_length,distToMouse));
  
  // Draw the line from the point to the mouse (or towards the
  // mouse to the length of the radius, if that distance is
  // shorter).
  line(_pt.x,_pt.y,_pt.x + mouse.x,_pt.y + mouse.y);
}