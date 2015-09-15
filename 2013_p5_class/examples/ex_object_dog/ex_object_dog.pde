Dog a;
Dog b;
Dog c;

int clickCount = 0;

boolean barked = true;

void setup() {
   size(400,400);
   
   a = new Dog();
   a.setType("French Bulldog");
   a.setBarkLimit(15);
   
   b = new Dog();
   b.setType("Poodle");
   b.setBarkLimit(4);
   
   c = new Dog();
}

void draw() {
  if (!barked) {
    println("-----------------------");
    println("You have clicked " + clickCount + " times");
    println("-----------------------");
    
    println("The " + a.type + " says: ");
    a.bark();
    
    println("The " + b.type + " says: ");
    b.bark();
    
    println("The " + c.type + " says: ");
    c.bark();
    
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
    println("Ruf ruf.");
    barkCount += 1;
  } 

  void setType(String newType) {
    type = newType;
  }
  
  void setBarkLimit(int limit) {
    barkLimit = limit; 
  }
}

