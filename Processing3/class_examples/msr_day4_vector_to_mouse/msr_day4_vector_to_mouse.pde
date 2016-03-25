float radius = 50;
PVector somePoint;

void setup() {
  size(400, 400);
  
  // This is just an arbitrary point.
  somePoint = new PVector(300,200);
}

void draw() {
  background(255);
  fill(255);
  // Draw a circle so we can see the radius around
  // the point that we created.
  ellipse(somePoint.x,somePoint.y,radius*2,radius*2);
  
  // Draw a line from the point towards the mouse,
  // not exceeding the radius in length. 
  drawFromPointTowardsMouse(somePoint,radius);
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