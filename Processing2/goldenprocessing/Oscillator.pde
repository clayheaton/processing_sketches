class Oscillator{
  float min;
  float max;
  float theta;
  float rate;
  float diff;
  float current_value;
  Oscillator(float _min, float _max, float _rate){
    min  = _min;
    max  = _max;
    rate = _rate;
    diff = max - min;
    
    current_value = min;
  }
  
  float oscillate(){
     theta += rate;
     float delta = abs(sin(theta) * diff);
     current_value = min + delta;
     return current_value;
  }
}
