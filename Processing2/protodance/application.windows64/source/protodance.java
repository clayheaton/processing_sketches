import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class protodance extends PApplet {

int screen_width      = 5760;
int screen_height     = 2304;
float run_factor      = 1;
int width_functional  = PApplet.parseInt(screen_width * run_factor);
int height_functional = PApplet.parseInt(screen_height * run_factor);

int outersquare       = PApplet.parseInt(width_functional / 8.0f);

// For color shifting
int hour_of_day = 1;

ArrayList<ColorObj> colors;
ArrayList<ColorObj> blue_colors;
ArrayList<ColorObj> orange_colors;
ArrayList<ColorObj> green_colors;
ArrayList<ColorObj> maroon_colors;

ProtoCircle t;
int number_circles = 14;
int points_around_circle = 20;

float rotate_angle = 0;
float rotate_rate  = 0.002f;
float extra_rotate_rate = 0.002f;

float translate_x = -outersquare;
float translate_y = -outersquare;


public void setup() {
  size(5760, 2304,OPENGL);

  colors        = new ArrayList<ColorObj>(); // probably not necessary
  blue_colors   = new ArrayList<ColorObj>();
  orange_colors = new ArrayList<ColorObj>();
  green_colors  = new ArrayList<ColorObj>();
  maroon_colors = new ArrayList<ColorObj>();

  blue_colors.add(new ColorObj(0xff0E4E7F));
  blue_colors.add(new ColorObj(0xff51B3FF));
  blue_colors.add(new ColorObj(0xff1D9DFF));
  blue_colors.add(new ColorObj(0xff649EDB));
  blue_colors.add(new ColorObj(0xff176FCC));
  blue_colors.add(new ColorObj(0xff768EBD));
  blue_colors.add(new ColorObj(0xff58CFFF));

  orange_colors.add(new ColorObj(0xffD40000));
  orange_colors.add(new ColorObj(0xffFF3800));
  orange_colors.add(new ColorObj(0xffB31B1B));
  orange_colors.add(new ColorObj(0xffF94D00));
  orange_colors.add(new ColorObj(0xffFF7E00));
  orange_colors.add(new ColorObj(0xffFF2400));
  orange_colors.add(new ColorObj(0xffE48400));

  green_colors.add(new ColorObj(0xff00CC31));
  green_colors.add(new ColorObj(0xff3A7047));
  green_colors.add(new ColorObj(0xff00B22B));
  green_colors.add(new ColorObj(0xff2ABF4E));
  green_colors.add(new ColorObj(0xff007F1F));
  green_colors.add(new ColorObj(0xff5FBF64));
  green_colors.add(new ColorObj(0xff357048));

  maroon_colors.add(new ColorObj(0xff75111B));
  maroon_colors.add(new ColorObj(0xff96434C));
  maroon_colors.add(new ColorObj(0xffC91D2F));
  maroon_colors.add(new ColorObj(0xffD25E6A));
  maroon_colors.add(new ColorObj(0xff961623));
  maroon_colors.add(new ColorObj(0xffC9261E));
  maroon_colors.add(new ColorObj(0xff962A48));

  int h = hour() % 4;
  if (h == 0) {
    // Blue
    println("color set to blue");
    colors = blue_colors;
  } else if (h == 1) {
    // Red and Orange
    println("color set to orange");
    colors = orange_colors;
  } else if (h == 2) {
    // Green
    println("color set to green");
    colors = green_colors;
  } else if (h == 3) {
    // Maroon
    println("color set to maroon");
    colors = maroon_colors;
  }

  t = new ProtoCircle(points_around_circle);
  //smooth();
}

public void draw() {
  set_colors();
  
  background(colors.get(0).getColor());
  pushMatrix();
  translate(translate_x, translate_y);
  rotate(rotate_angle);
  scale(width_functional*1.25f);
  stroke(0);
  strokeWeight(0.02f);

  for (int i = 1; i < number_circles; i++) {
    rotate(0.1f);
    fill(get_color(i%colors.size()));
    t.display();
    scale(0.8f);
  }

  // t.debugDisplay();
  popMatrix();

  rotate_angle += rotate_rate;
  
  if(translate_x <= width_functional+outersquare && translate_y <= -outersquare){
    translate_x += 1; 
  }else if(translate_x >= width_functional+outersquare && translate_y <= height_functional+outersquare){
   translate_y += 1; 
  }else if(translate_y >= height_functional+outersquare && translate_x > 0-outersquare) {
   translate_x -= 1; 
  }else if (translate_y >= 0-outersquare && translate_x <= 0-outersquare){
   translate_y -= 1; 
  }
  
}

public int get_color(int i) {
  int c = colors.get(i).getColor();
  return c;
}

public void set_colors() {
  int _hour = hour();

  if (_hour != hour_of_day) {
    hour_of_day = _hour;
    int c = hour_of_day % 4;
    if (c == 0) {
      colors = blue_colors;
    } else if (c == 1) {
      colors = orange_colors;
    } else if (c == 2) {
      colors = green_colors;
    } else if (c == 3) {
      colors = maroon_colors;
    }
    t = new ProtoCircle(points_around_circle);
  }
}

/* Comment out this method if you don't want full screen */
/*
boolean sketchFullScreen() {
  return true;
}
*/

class ColorObj {
  int c;
  ColorObj(int _c){
    c = _c;
  }
  public void setColor(int _c){
    c = _c;
  }
  public int getColor(){
    return c;
  }
}
    
/* A proto circle is a shape that is like a circle with an additional rippled edge.
 The rippled edge is between the values of 1 and 2. Scale them to draw.
 This is a terrible explanation.
 */
class ProtoCircle {
  int numPoints;
  float angle_delta;
  ArrayList<PVector>points;

  ProtoCircle(int _numPoints) {
    numPoints = _numPoints;
    angle_delta = radians(360.0f/(numPoints));
    points = new ArrayList<PVector>();
    establishPoints();
  }

  public void establishPoints() {
    // Start at 0 degrees
    float angle = 0.0f;
    float d = random(1) + 1;
    PVector p = pointOnCircle(0, 0, d, 0);
    points.add(p);

    for (int i = 0; i < numPoints-1; i++) {
      angle += angle_delta;
      d = random(1) + 1;
      PVector pt = pointOnCircle(0, 0, d, angle);
      points.add(pt);
    }
  }  

  public PVector pointOnCircle(float _cx, float _cy, float _diameter, float _angle) {
    float x = _cx + _diameter/2.0f * sin(_angle);
    float y = _cy + _diameter/2.0f * cos(_angle);
    PVector thePoint = new PVector(x, y);
    return thePoint;
  }

  public void display() {
    //noStroke();
    //strokeWeight(0.02);
    //stroke(255);
    PVector startEnd = points.get(0);
    beginShape(); 
    curveVertex(startEnd.x, startEnd.y);
    curveVertex(startEnd.x, startEnd.y);
    for (int i = 1; i < points.size (); i++) {
      PVector p = points.get(i);
      curveVertex(p.x, p.y);
    }
    curveVertex(startEnd.x, startEnd.y);
    curveVertex(startEnd.x, startEnd.y);
    endShape(CLOSE);
  }

  public void debugDisplay() {
    for (int i = 0; i < points.size (); i++) {
      fill(255, 0, 0);
      noStroke();
      PVector p = points.get(i);
      ellipse(p.x, p.y, 5, 5);
    }

    stroke(0, 0, 255);
    noFill();
    strokeWeight(1);
    ellipse(0, 0, 100, 100);
    ellipse(0, 0, 200, 200);
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "protodance" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
