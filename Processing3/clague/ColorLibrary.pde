class ColorLibrary {
  HashMap<String, RColor> colors;

  ColorLibrary(JSONArray _colorArray) {
    colors = new HashMap<String, RColor>();

    // Iterate through _colorArray and assign colors to the HashMap
    for (int i = 0; i < _colorArray.size(); i++) {
      JSONObject color_json = _colorArray.getJSONObject(i);
      String color_name = color_json.getString("name");
      int r             = color_json.getInt("r");
      int g             = color_json.getInt("g");
      int b             = color_json.getInt("b");
      int a             = color_json.getInt("a");

      RColor c = new RColor(color(r, g, b, a));
      colors.put(color_name, c);
    }
  }

  color colorForName(String _colorName) {
    if (colors.containsKey(_colorName)) {
      RColor rc = colors.get(_colorName);
      return rc.getColor();
    } else {
      return color(255,0,0); 
    }
  }
}