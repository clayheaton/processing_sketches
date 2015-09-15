// Declare some instances of the Dog class
Dog a;
Dog b;
Dog c;
Dog[] dogs = new Dog[3];

// Keep track of how many times you've clicked the mouse
int clickCount = 0;

// Used as flow control... er bark control
boolean barked = true;

void setup() {
   size(400,400);
   
   // Create a and b with the alternate constructor
   a = new Dog("French Bulldog", 15);
   dogs[0] = a;
   
   b = new Dog("Poodle", 4);
   dogs[1] = b;
   
   // Create c with the default constructor
   c = new Dog();
   dogs[2] = c;
}

void draw() {
  // Only execute the code here when barked is false
  if (!barked) {
    println("-----------------------");
    println("You have clicked " + clickCount + " times");
    println("-----------------------");
    
    // Iterate through the array of dogs and try to make them bark.
    for(int i = 0; i < dogs.length; i++) {
      dogs[i].bark();
    }
    
    barked = true;
  }
}

// Detect mouse clicks (and do stuff with them)
void mouseClicked() {
   barked = false; 
   clickCount += 1;
}

