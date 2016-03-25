Rotator rot;

void setup(){
  size(300,300);
  rot = new Rotator(15,50,7,false);
  background(255);
  stroke(0);
  strokeWeight(3);
  strokeCap(SQUARE);
  noFill();
}

void draw(){
  background(255);
  rot.displayAt(width/2,height/2);

}