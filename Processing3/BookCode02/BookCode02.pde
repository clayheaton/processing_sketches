
void setup(){
  size(600,600);
  // pixelDensity(2);
  background(255);
}

void draw(){
 
  String h = "I removed the answer so you folks wouldn't cheat. :D";
  
  Encoder e = new Encoder();
  e.space = true;
  e.lettersPerRow = 10;
  e.makeSquare = true;
  e.displayAt(h,10,50,50);
  
  noLoop();
}