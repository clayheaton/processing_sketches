
void setup(){
  size(400,400);
  background(255);
  fill(200,200,200,50);
  noStroke();
}

void draw(){
  
  if(mousePressed){
   int myRed   = (int)random(0,255); 
   int myGreen = (int)random(0,255); 
   int myBlue  = (int)random(0,255); 
   int myAlpha = (int)random(0,255);
   fill(myRed,myGreen,myBlue,myAlpha);
  }
  
  rect(mouseX,mouseY,50,50);
  
}