PFont myfont;
PFont mySmallerFont;

void setup(){
  size(400,400);
  background(255);
  myfont = loadFont("MarkerFelt-Thin-100.vlw");
  mySmallerFont = loadFont("MarkerFelt-Thin-24.vlw");
}

void draw(){
  
  background(255);
  fill(255,0,0);
  textFont(myfont,100);
  text(mouseX,100,100);
  
  textFont(mySmallerFont,24);
  text(mouseY,100,200);
}