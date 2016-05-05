
void setup(){
  size(600,600);
  // pixelDensity(2);
  background(255);
}

void draw(){
 
  String h = "Tom Chick writes the best game reviews available on the interwebs.";
  
  Encoder e = new Encoder();
  e.space = true;
  e.lettersPerRow = 10;
  e.makeSquare = true;
  e.displayAt(h,10,50,50);
  
  noLoop();
}