// You must import this library to output to PDF
import processing.pdf.*;

// Check whether we are recording
boolean recording = false;

void setup() {
  size(1000, 240); 
  background(255);
  
  // Slow down to something reasonable
  frameRate(15);
}

void draw() {
  // If the 'recording' variable is true, start recording
  if (recording) {
    beginRecord(PDF, "print-###.pdf");
  }

  // Put all of the drawing code here
  background(255);
  noStroke();
  drawCircles(1000);

  /*
    If we are recording, then stop!
    If we don't set recording back to false, then we will get
    one PDF file per pass through the draw() loop - 15 per second!
   */
  if (recording) {
    endRecord(); 
    recording = false;
  }
}


// A simple function to draw circles of random size and location.
void drawCircles(int numCircles) {
  for (int i = 0; i < numCircles; i ++) {
    fill(100,100,100,50);
    int diameter = (int)random(40);
    ellipse(random(width), random(height), diameter, diameter);
  }
}

// A Processing function to listen for key press events.
void keyPressed() {
  // If you press the 'p' key, then we set the value
  // of the recording variable to true.
  if (key == 'p') {
    recording = true;
  }
}