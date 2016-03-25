
ArrayList<Raindrop> drops;

void setup() {
  size(550, 550);
  background(255);

  drops = new ArrayList<Raindrop>();

  // this is where you create the raindrops
  for (int i = 0; i < 1000; i++) {
    Raindrop r = new Raindrop(1,5);
    drops.add(r);
  }
}

void draw() {
  background(255);
  
  // This is where you draw and update the rain
  for (Raindrop myDrop : drops){
    myDrop.display();
    myDrop.update();
  }
  
  stroke(0);
  strokeWeight(5);
  fill(255,0,0);
  arc(mouseX,mouseY,100,100,radians(180),radians(360));
  line(mouseX,mouseY,mouseX,mouseY + 50);
  line(mouseX - 50, mouseY, mouseX + 50, mouseY);
  
}