Chart a;

PFont f;

int[][] data = {
    {1,2,3,4,5},
    {6,4,9,2,1},
    {9,9,9,2,5},
    {3,4,5},
    {67,45,55,50,53},
    {5,7,4,3,8,7,9,3,4,5,2,12,8,6,7,5,7}
};

void setup() {
  size(600,600);
  
  PVector chartOrigin = new PVector(100,100);
  
  // Create a new chart with the data above, at (100,100),
  // that is 400px by 400px
  a = new Chart(data, chartOrigin, 400);
  
  background(255);
  smooth();
  
  f = loadFont("Miriam-24.vlw");
  textFont(f);
  textAlign(RIGHT);
}

void draw() {
  background(255);
  
  drawButton();
  
  a.display();
}

void drawButton() {
   fill(0);
   rect(width * 0.5 - 40, height - 50, 80, 40);
   
   fill(#ff0000);
   text("NEXT", width * 0.5 + 28, height - 22);
}

void mouseClicked() {
   if (mouseX > (width * 0.5 - 40) && mouseX < (width * 0.5 + 40)) {
      if (mouseY > height - 50 && mouseY < height - 10) {
         println("clicked button");
         a.nextSeries(); 
      }
   } 
}
