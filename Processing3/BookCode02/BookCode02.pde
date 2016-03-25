
void setup(){
  size(600,600);
  pixelDensity(2);
  background(255);
}

void draw(){
 
  String h = "The entrance to this room is restricted. Please contact Rector Brown for more information.";
  
  Encoder e = new Encoder();
  e.space = true;
  e.lettersPerRow = 10;
  e.makeSquare = true;
  e.displayAt(h,10,50,50);
  
  noLoop();
}