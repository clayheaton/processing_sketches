MyClass m;

void setup(){
 size(400,400);
 background(255);
 m = new MyClass();
 m.x = width/2;
 m.y = height/2;
}

void draw(){
 background(255); 
 m.display();
}

void keyPressed(){
 if(key == 'k'){
   m.x += 10;
 }
 if(key == 'j'){
  m.x -= 10; 
 }
}