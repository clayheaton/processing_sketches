void setup(){
 size(550,500);
 background(255);
 stroke(0);
 
}

void draw(){
  if(pmouseX == 0 && pmouseY == 0){
    //skip
  } else {
    strokeWeight(abs(mag(mouseX-pmouseX,mouseY-pmouseY)));
    line(pmouseX,pmouseY,mouseX,mouseY);
  }
}