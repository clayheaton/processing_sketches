class JSONRect {
  float x, y, w, h;
  color fillColor, strokeColor;
  float strokeWeight;
  boolean no_fill, no_stroke;
  JSONRect(JSONObject _rect) {
    x = _rect.getFloat("x") * width;
    y = _rect.getFloat("y") * height;
    w = _rect.getFloat("w") * width;
    h = _rect.getFloat("h") * height;
    
    no_fill   = false;
    no_stroke = false;
    
    String fill_name = _rect.getString("fill");
    if (fill_name.equals("noFill")) {
      no_fill = true;
    } else {
      no_fill = false;
      fillColor = color_library.colorForName(fill_name);
    }

    String stroke_name = _rect.getString("stroke");
    println(stroke_name);
    if (stroke_name.equals("noStroke")) {
      no_stroke = true;
    } else {
      no_stroke = false;
      strokeColor  = color_library.colorForName(stroke_name); 
      strokeWeight = _rect.getFloat("strokeWeight");
      
    }
  }
  
  void display(){
    
    if(no_fill == true){
      noFill();
    } else {
      fill(fillColor);
    }
    
    if(no_stroke == true){
      noStroke();
    } else {
      stroke(strokeColor);
      strokeWeight(this.strokeWeight);
    }
    
    
    
    pushMatrix();
    translate(this.x,this.y); 
    rect(0, 0, this.w, this.h);
    popMatrix();
  }
}