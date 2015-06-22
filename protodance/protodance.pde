int screen_width      = 5760;
int screen_height     = 2304;
float run_factor      = 0.2;
int width_functional  = int(screen_width * run_factor);
int height_functional = int(screen_height * run_factor);

int outersquare       = int(width_functional / 8.0);

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
float rotate_rate  = 0.002;
float extra_rotate_rate = 0.002;

float translate_x = -outersquare;
float translate_y = -outersquare;


void setup() {
  size(width_functional, height_functional,OPENGL);

  colors        = new ArrayList<ColorObj>(); // probably not necessary
  blue_colors   = new ArrayList<ColorObj>();
  orange_colors = new ArrayList<ColorObj>();
  green_colors  = new ArrayList<ColorObj>();
  maroon_colors = new ArrayList<ColorObj>();

  blue_colors.add(new ColorObj(#0E4E7F));
  blue_colors.add(new ColorObj(#51B3FF));
  blue_colors.add(new ColorObj(#1D9DFF));
  blue_colors.add(new ColorObj(#649EDB));
  blue_colors.add(new ColorObj(#176FCC));
  blue_colors.add(new ColorObj(#768EBD));
  blue_colors.add(new ColorObj(#58CFFF));

  orange_colors.add(new ColorObj(#D40000));
  orange_colors.add(new ColorObj(#FF3800));
  orange_colors.add(new ColorObj(#B31B1B));
  orange_colors.add(new ColorObj(#F94D00));
  orange_colors.add(new ColorObj(#FF7E00));
  orange_colors.add(new ColorObj(#FF2400));
  orange_colors.add(new ColorObj(#E48400));

  green_colors.add(new ColorObj(#00CC31));
  green_colors.add(new ColorObj(#3A7047));
  green_colors.add(new ColorObj(#00B22B));
  green_colors.add(new ColorObj(#2ABF4E));
  green_colors.add(new ColorObj(#007F1F));
  green_colors.add(new ColorObj(#5FBF64));
  green_colors.add(new ColorObj(#357048));

  maroon_colors.add(new ColorObj(#75111B));
  maroon_colors.add(new ColorObj(#96434C));
  maroon_colors.add(new ColorObj(#C91D2F));
  maroon_colors.add(new ColorObj(#D25E6A));
  maroon_colors.add(new ColorObj(#961623));
  maroon_colors.add(new ColorObj(#C9261E));
  maroon_colors.add(new ColorObj(#962A48));

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
}

void draw() {
  set_colors();
  
  background(colors.get(0).getColor());
  pushMatrix();
  translate(translate_x, translate_y);
  rotate(rotate_angle);
  scale(width_functional*1.25);
  stroke(0);
  strokeWeight(0.02);

  for (int i = 1; i < number_circles; i++) {
    rotate(0.1);
    fill(get_color(i%colors.size()));
    t.display();
    scale(0.8);
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

color get_color(int i) {
  color c = colors.get(i).getColor();
  return c;
}

void set_colors() {
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

