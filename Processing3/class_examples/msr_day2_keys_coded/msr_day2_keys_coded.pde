int y = 150;

void setup(){
 size(400,400); 
}

void draw(){
 background(204);
 line(25,height/2,width-25,height/2);
 if (key == CODED) {
  if (keyCode == UP) {
   y = 100; 
  } else if (keyCode == DOWN) {
   y = 200; 
  }
 } else {
  y = 150; 
 }
 rect(50,y,width - 100,100);
}