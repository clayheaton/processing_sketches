PImage pic;

void setup(){
 size(600,600); 
 pic = loadImage("face.png");
}

void draw(){
  background(255);
  image(pic,mouseX,mouseY,pic.width/10,pic.height/10);
}