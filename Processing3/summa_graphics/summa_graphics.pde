
PImage desk_student;

void setup(){
 size(100,100);
 pixelDensity(2);
 background(255);
 noStroke();
 fill(0);
 
 desk_student = loadImage("desk_student.png");
}

void draw(){
  background(255);
  
  image(desk_student,10,10);
  
  noLoop();
}