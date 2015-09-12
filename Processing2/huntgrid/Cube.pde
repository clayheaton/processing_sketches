class Cube {
  PVector pos;
  ColorObj currentColor;
  ColorObj targetColor;
  
  float w;
  float h;
  float d;
  
  Cube(float _x, float _y, float _w, float _h, float _d, ColorObj _currentColor) {
    pos = new PVector(_x,_y);
    currentColor = _currentColor;
    
    // dimensions width, height, depth
    w = _w;
    h = _h;
    d = _d;
  }
  
  void set_transition(int _rot_direction, ColorObj _target_color, int _frames){
    
  }
  
  void start_transition(){
    
  }
  
  void finish_transition(){
    
  }
  
  void transition(){
    
  }
  
  void update(){
    
  }
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    fill(currentColor.getColor());
    stroke(currentColor.getColor());
    box(w,h,d);
    popMatrix();
    
    
  }
  

}

