
void setup(){
 size(400,400); 
 background(255);
}

void draw(){
 
}

void mouseDragged(){
 background(0); 
}

void mouseMoved(){
 background(0,255,0); 
}

void mousePressed(){
  background(255,0,0);
}

void mouseReleased(){
  background(255);
}

void keyPressed() {
  if (key == CODED){
   if (keyCode == UP){
    background(0,255,0); 
   } else if (keyCode == DOWN) {
    background(0,0,255); 
   }
  }
  
  // CODED
  // ALT,CONTROL,SHIFT,UP,DOWN,LEFT,RIGHT
  
  // Recognized as normal keys
  // BACKSPACE, TAB, ENTER, RETURN, ESC, DELETE
  
  if (key == 'r' || key == 'R') {
    background(255,0,0);
  } else if (key == 'b' || key == 'B'){
    background(255); 
  } else if (key == ENTER) {
    background(255,0,255); 
  }
}