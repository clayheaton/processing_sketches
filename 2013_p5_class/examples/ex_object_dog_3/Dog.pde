class Dog {
  String type;
  int barkLimit;
  int barkCount;

  // Constructors
  Dog() {
    type      = "Mutt";
    barkLimit = 2;
    barkCount = 0;
  }

  Dog(String dogType, int tBarkLimit) {
    type      = dogType;
    barkLimit = tBarkLimit;
    barkCount = 0;
  }

  // Dog instance methods
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

