
// Use this to store some boxes.
ArrayList<MyBox> boxes;

// How many boxes do you want to create?
int numBoxes = 8;

void setup() {
  size(300, 300);
  background(255);

  // Initialize the storage.
  boxes = new ArrayList<MyBox>();

  // Create some boxes
  for (int i = numBoxes; i > 0; i--) {
    // Call the construction function for the MyBox class
    MyBox b = new MyBox();
    // Add the MyBox instance we created to the boxes ArrayList
    boxes.add(b);
  }
}

void draw() {
  // Paint the canvas white
  background(255);

  // Tell each MyBox object to display itself
  for (MyBox b : boxes) {
    b.display();
  }
}

// ==================================================
// Here is the class definition we will use for 
// boxes that know whether we have hovered over them.
class MyBox {
  // The vector each box will use to track its position.
  PVector position;

  // The vector each box will use to track its velocity.
  PVector velocity;

  // Variables for tracking the size of each box
  int w, h;

  // Track if we have hovered the mouse over this box
  boolean haveHovered;

  // The "constructor" function for the class
  MyBox() {
    // Initialize hover state
    this.haveHovered = false;

    // Set a random size for the box when it is created
    this.w = int(random(40, 80));
    this.h = int(random(40, 80));

    // Initialize the PVector we'll use to store position
    this.position = new PVector();

    // Set a random position on the screen for each box
    // when it is created. PVector holds floats.
    this.position.x = random(0, width - this.w);
    this.position.y = random(0, height - this.h);

    // Initialize a velocity for the box
    this.velocity = new PVector();

    // Set an initial velocity between -1 and 1 on both axes
    this.velocity.x = random(-1, 1);
    this.velocity.y = random(-1, 1);
  }

  // The MyBox class method - the code that allows a MyBox
  // object to know how to draw itself.
  void display() {

    // Add the velocity to the position
    // This PVector method mutates the original position
    // instead of creating and returning a new PVector.
    this.position.add(this.velocity);

    // Check if we need to reverse one of the
    // velocity directions.
    this.checkDirection();

    // Call the hitDetection method
    this.hitDetection();

    // Draw the box
    rect(this.position.x, this.position.y, this.w, this.h);
  }

  void checkDirection() {
    // Check the x direction
    if (this.position.x <= 0) {
      this.velocity.x = abs(this.velocity.x);
    } else if (this.position.x + this.w >= width){
      this.velocity.x *= -1; 
    }
    
    // Check the y direction
    if (this.position.y <= 0) {
      this.velocity.y = abs(this.velocity.y);
    } else if (this.position.y + this.h >= height){
      this.velocity.y *= -1; 
    }
  }

  void hitDetection() {
    if (mouseX >= this.position.x          &&
        mouseX <= this.position.x + this.w &&
        mouseY >= this.position.y          &&
        mouseY <= this.position.y + this.h) 
    {
      // If we meet those conditions, color red
      fill(255, 0, 0);

      // Change state to know this box has been hovered over
      this.haveHovered = true;
    } else if (this.haveHovered) {
      // If we have hovered over it previously,
      // color transluscent purple
      fill(255, 0, 255, 50);
    } else {
      // Otherwise, color transluscent grey
      fill(0, 50);
    }
  }
}