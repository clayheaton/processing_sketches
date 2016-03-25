// Declare the class
class Dog {
  // 'Instance variables'
  String name;
  String breed;
  
  // This is the 'constructor'
  Dog(String _name, String _breed) {
    // Store constructor params in the object
    name  = _name;
    breed = _breed;
  }
  
  // This function is called a "method"
  // because it belongs to a class.
  void bark(){
   println(name + " barks loudly!"); 
  }
}