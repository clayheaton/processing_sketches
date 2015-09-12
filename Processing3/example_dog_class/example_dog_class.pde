
Dog myDog;

void setup(){
 myDog = new Dog("Fido","Basset Hound"); 
}

void draw(){
  myDog.bark();
  println(myDog.breed);
  noLoop();
}