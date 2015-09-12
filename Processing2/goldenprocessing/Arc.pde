class Arc {
  PVector center;
  float diameter;
  float degree_start;
  float degree_stop;
  float stroke_width;
  boolean is_root;
  float attachment_angle;
  int color_index;
  Arc child_arc;
  Arc parent_arc;

  Arc(PVector _center, float _diameter, float _degree_start, float _degree_stop, float _stroke_width, int _arc_count, boolean _is_root, float _attachment_angle, Arc _parent_arc, int _color_index) {
    center = _center;
    diameter = _diameter;
    degree_start = _degree_start;
    degree_stop  = _degree_stop;
    stroke_width = _stroke_width;
    is_root      = _is_root;
    attachment_angle = _attachment_angle;
    color_index      = _color_index;
    child_arc        = null;
    parent_arc       = _parent_arc;

    // Recursively create child arcs, if there are any to be created.
    if (_arc_count > 0) {
      float new_diameter = diameter * arc_diameter_decay;
      float new_degree_start = degree_start + arc_angle_of_attachment;
      float new_degree_stop  = degree_stop  + arc_angle_of_attachment;
      float new_stroke_width = stroke_width * stroke_decay;
      float new_attachment_angle = attachment_angle + arc_angle_of_attachment;
      int   new_color_index      = (color_index + 1) % colors.size();
      PVector new_center         = new PVector(center.x, center.y);

      child_arc = new Arc(new_center, new_diameter, new_degree_start, new_degree_stop, new_stroke_width, _arc_count - 1, false, new_attachment_angle, this, new_color_index);
    }
  }

  void update_arc_degrees(float _start_degree, float _stop_degree) {
    degree_start = _start_degree;
    degree_stop  = _stop_degree;

    if (null != child_arc) {
      float new_start_degree = degree_start + arc_angle_of_attachment;
      float new_stop_degree  = degree_stop  + arc_angle_of_attachment;
      child_arc.update_arc_degrees(new_start_degree, new_stop_degree);
    }
  }

  void update_diameter_decay(float _new_diameter_decay) {
    // Do not change the diameter of the outermost arc
    if (!is_root) {
      diameter = parent_arc.diameter * _new_diameter_decay;
    }

    if (null != child_arc) {
      child_arc.update_diameter_decay(_new_diameter_decay);
    }
  }

  void update_arc_angle_of_attachment(float _new_arc_angle_of_attachment) {
    attachment_angle = radians(_new_arc_angle_of_attachment);

    if (null != child_arc) {
      float new_child_arc_angle_of_attachment = attachment_angle; // + _new_arc_angle_of_attachment
      child_arc.update_arc_angle_of_attachment(new_child_arc_angle_of_attachment);
    }
  }

  void update_stroke_decay(float _new_stroke_decay) {
    if (!is_root) {
      stroke_width = parent_arc.stroke_width * 0.99; // * _new_stroke_decay;
    }

    if (null != child_arc) {
      child_arc.update_stroke_decay(_new_stroke_decay);
    }
  }

  PVector point_along_arc(float _cx, float _cy, float _diameter, float _arc_angle) {
    float x = _cx + _diameter/2.0 * cos(radians(_arc_angle));
    float y = _cy + _diameter/2.0 * sin(radians(_arc_angle));
    PVector answer = new PVector(x, y);
    return answer;
  }

  void set_position() {
    PVector vecB = point_along_arc(parent_arc.center.x, parent_arc.center.y, parent_arc.diameter, attachment_angle);
    PVector vecA = new PVector(parent_arc.center.x, parent_arc.center.y);
    PVector new_center = PVector.lerp(vecA, vecB, 1 - arc_diameter_decay);
    
    center = new PVector(new_center.x, new_center.y);
    
    if(null == child_arc){
       spiral_center = center; 
    }
  }
  
  void display(){
     if(!is_root){
        set_position();
     } 
     
     strokeWeight(stroke_width);
     noFill();
     color c = colors.get(color_index).getColor();
     stroke(c);
     
     pushMatrix();
     translate(-spiral_center.x, -spiral_center.y);
     arc(center.x, center.y, 200, 200, radians(degree_start % 360), radians(degree_stop % 360));
     // println("HALF_PI:" + HALF_PI + ", degree_start:" + radians(degree_start % 360) + ", degree_stop:" + radians(degree_stop % 360));
     //ellipse(center.x,center.y,100,100);
     popMatrix();
     
     if(null != child_arc){
        child_arc.display(); 
     }
     
  }
}

