Encoder e;
//String s = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+=-,./[]!";
// String s = "This is a secret message for Dave Perkins. Can you figure out what it says? Good luck!END jdlska jdkfloeiajn jdks hwiel lsk d.";

String s = "abcdefghijklmnopqrstuvwxyz";

int margin  = 30;
int padding = 5;

void setup() {
  size(600, 600);
  pixelDensity(2);
  randomSeed(3);
  e = new Encoder(s,100,5);
  background(255);
  
}

void draw() {
  e.displayCode();
  noLoop();
}