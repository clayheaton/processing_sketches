// For loop example
void setup() {
  size(400, 400);
}

void draw() {
  // Set the background to white
  background(255);
  
  // No stroke
  noStroke();
  
  // Fill Color to red
  fill(255,0,0);
  
  // For loop
  // i is a variable that we establish in the loop.
  // To determine if we should loop again, we check
  // to see if i is less than 10. If it is less than
  // 10, we loop again. After we loop, we add 1
  // to i at the end of the loop and then check to 
  // see if it is less than 10. If it is not, then 
  // we do not loop any more.
  
  for (int i = 1; i < 10; i++){
    int x = i * (width/10);
    int w = 30;
    int h = w + (i*20);
    
    ellipse(x,height/2,w,h);
  }
}