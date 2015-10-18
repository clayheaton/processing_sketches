
Circle c1, c2, c3;

ArrayList<Circle> circles;

void setup(){
  size(400,400);
  c1 = new Circle();
  c2 = new Circle(300,100);
  c3 = new Circle(true);
  
  circles = new ArrayList<Circle>();
  circles.add(c1);
  circles.add(c2);
  
  
  for(int i = 0; i < 100; i++){
   Circle c = new Circle(random(width),random(height));
   circles.add(c);
  }
  
  circles.add(c3);
}


void draw(){
  background(255);
  
  for (Circle c : circles){
   c.update();
   c.display(); 
  }
  
}