Dog a;
Dog b;
Dog c;
Dog[] dogs = new Dog[3];

int clickCount = 0;

boolean barked = true;

void setup() {
   size(400,400);
   
   a = new Dog();
   a.setType("French Bulldog");
   a.setBarkLimit(15);
   dogs[0] = a;
   
   b = new Dog();
   b.setType("Poodle");
   b.setBarkLimit(4);
   dogs[1] = b;
   
   c = new Dog();
   dogs[2] = c;
   
   
}

void draw() {
  if (!barked) {
    println("-----------------------");
    println("You have clicked " + clickCount + " times");
    println("-----------------------");
    
    for(int i = 0; i < dogs.length; i++) {
      dogs[i].bark();
    }
    
    println("-----------------------");
    barked = true;
  }
}

void mouseClicked() {
   barked = false; 
   clickCount += 1;
}







class Dog {
  String type = "Mutt";
  int barkLimit = 2;
  int barkCount = 0;
  Dog() {
  }

  void bark() {
    if (barkCount >= barkLimit) {
      println("The " + this.type + " is too tired to bark.");
      return;
    }
    println("The " + this.type + " says woof woof.");
    barkCount += 1;
  } 

  void setType(String newType) {
    type = newType;
  }
  
  void setBarkLimit(int limit) {
    barkLimit = limit; 
  }
}

