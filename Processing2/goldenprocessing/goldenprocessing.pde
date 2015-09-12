int screen_width      = 5760;
int screen_height     = 2304;

float run_factor      = 0.2;

int width_functional  = int(screen_width * run_factor);
int height_functional = int(screen_height * run_factor);

float arc_initial_diameter = float(height_functional);

int total_arcs     = 150;
float stroke_width = 320 * run_factor;
float stroke_decay = 0.90;

Oscillator stroke_decay_oscillator;

float arc_diameter_decay      = 0.75;
Oscillator arc_diameter_decay_oscillator;

float arc_angle_of_attachment = -45.0;

float arc_degree_start = 90.0;
float arc_degree_stop  = -120.0;

Oscillator arc_degree_start_oscillator;
Oscillator arc_degree_stop_oscillator;

ArrayList<ColorObj> colors;
ArrayList<ColorObj> blue_colors;
ArrayList<ColorObj> orange_colors;
ArrayList<ColorObj> green_colors;
ArrayList<ColorObj> maroon_colors;

Arc root_arc;
PVector root_arc_center;

// For rotation...
float rotate_angle       = 0.0;
float rotate_angle_delta = 0.2;
Oscillator rotation_oscillator;

// For animation
PVector spiral_center;

// For color shifting
int hour_of_day = 1;

void setup() {
  size(width_functional, height_functional);

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

  println(green_colors.size());

  spiral_center = new PVector(0, 0);

  arc_diameter_decay_oscillator = new Oscillator(0.6, 0.85, 0.01);
  arc_degree_start_oscillator   = new Oscillator(200, 0, 0.004);
  arc_degree_stop_oscillator    = new Oscillator(0, -190, 0.009);
  stroke_decay_oscillator       = new Oscillator(0.55, 0.78, 0.008);

  root_arc_center = new PVector(width_functional/2.0, height_functional/2.0);
  root_arc = new Arc(root_arc_center, arc_initial_diameter, arc_degree_start, arc_degree_stop, stroke_width, total_arcs - 1, true, arc_angle_of_attachment, null, 0);
}

void draw() {
  background(0);
  set_colors();
  draw_rest();
  frameRate(10);
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
  }
}

void draw_rest() {
  pushMatrix();
  translate(width_functional/2.0, height_functional/2.0);

  float new_start = arc_degree_start_oscillator.oscillate();
  float new_stop  = arc_degree_stop_oscillator.oscillate();
  root_arc.update_arc_degrees(new_start, new_stop);

  float new_diameter_decay = arc_diameter_decay_oscillator.oscillate();
  root_arc.update_diameter_decay(new_diameter_decay);

  float new_stroke_decay = stroke_decay_oscillator.oscillate();
  root_arc.update_stroke_decay(new_stroke_decay);

  root_arc.display();
  popMatrix();
}

