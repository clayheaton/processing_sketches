// Here we're importing a java library that isn't native to Processing
// Read about it here: 
// http://docs.oracle.com/javase/6/docs/api/java/util/Random.html
import java.util.Random;

// Create an instance of the Random class
// and call it 'generator'
Random generator;

// Declare mean and standard deviation variables
float mean, sd;

void setup(){
  size(800,600);
  
  // Instantiate our generator object.
  generator = new Random();
  background(255);
  
  // Set the mean and standard deviation we want
  mean = width/2;
  sd   = 60;
  
  noStroke();
  fill(255,10);
  background(0);
}

void draw(){
  // Get an x value from the gaussian distribution.
  float xDist = (float)generator.nextGaussian();
  
  // Convert it to our canvas using the mean and sd
  float x = sd * xDist + mean;
  
  // Depending on the distance of x from the mean, set y
  float y = map(abs(width/2 - x),0,width/2,100,height - 200);
  
  // Draw a circle
  ellipse(x,y,15,15);
}