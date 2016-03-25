class MyClass {
  
  float x, y;
  PImage fish;
  
  MyClass(){
    fish = loadImage("fish.png");
  }
  
  void display(){

   image(fish,x,y,100,50);
  }
  
}