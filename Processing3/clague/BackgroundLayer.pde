/* Basic Layer that simply defined the background color and any text
 fixed to the background */

class BackgroundLayer extends Layer {
  color background_color, text_color;
  PFont background_font;

  BackgroundLayer(JSONObject _bgData) {
    rects = new ArrayList<JSONRect>();
    
    String bg_color = _bgData.getString("background_color");
    background_color = color_library.colorForName(bg_color);

    String tx_color = _bgData.getString("text_color");
    text_color = color_library.colorForName(tx_color);

    float font_size     = _bgData.getFloat("font-size");
    String font         = _bgData.getString("font");

    background_font     = createFont(font, font_size);

    JSONArray rectArray = _bgData.getJSONArray("rects");
    if (null != rectArray) {
      for (int i = 0; i < rectArray.size(); i++) {
        JSONObject thisRect = rectArray.getJSONObject(i);
        JSONRect jr = new JSONRect(thisRect);
        rects.add(jr);
      }
    }
  }

  void display() {
    background(background_color);
    
    if(rects.size() > 0){
     for(int i = 0; i < rects.size(); i++){
       JSONRect rc = rects.get(i);
       rc.display();
     }
    }
    
    if (debug)debugDisplay();
  }

  void debugDisplay() {
    textFont(background_font);
    fill(text_color);
    text("background color", 20, 20);
  }
}