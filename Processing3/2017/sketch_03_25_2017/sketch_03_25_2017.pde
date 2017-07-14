
ArrayList<Eye> eyes;

void setup(){
  size(300,300); 
  eyes = new ArrayList<Eye>();
  while (eyes.size() < 20) {
    Eye e = new Eye();
    boolean will_work = e.adjustDistFrom(eyes);
  }
}

void draw(){
  background(0);
  
  
}



class Eye {
  int outerR, innerR;
  int x, y;
  
 Eye(){
   outerR = 30;
   innerR = 20;
 }
 
 void display(){
 }
 
 
 
 boolean adjustDistFrom(ArrayList<Eye> eyes){
   for (Eye e : eyes){
      
   }
 }
}