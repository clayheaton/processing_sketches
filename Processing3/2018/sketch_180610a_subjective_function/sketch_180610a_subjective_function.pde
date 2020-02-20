String subj = "S U B J E C T I V E";
String func = "F\nU\nN\nC\n \nI\nO\nN";

String subj2 = "SUBJE\nCTIVE";
String func2 = "FUNC\nTION";

PFont f;

void setup(){
 size(800,800);

  f = loadFont("Courier-24.vlw");
  
  
  fill(0);
  noStroke();
}

void draw(){
  background(255);
  fill(0);
  textAlign(CENTER);
  text(subj,200,200);
  textAlign(CENTER);
  text(func,242.5,93);
  
  
  textFont(f,24);
  fill(0);
  textAlign(CENTER);
  text(subj2,100,500);
  fill(100);
  textAlign(CENTER);
  text(func2,170,500);
}
