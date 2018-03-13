import controlP5.*;
import java.util.*;

ControlP5 cp5;

void setup() {
  size(1280, 720); 

  cp5 = new ControlP5(this);
  List l = Arrays.asList("modules", "spaceships", "armadas");
  cp5.addScrollableList("dropdown")
     .setPosition(10, 10)
     .setSize(100, 130)
     .setBarHeight(30)
     .setItemHeight(30)
     .addItems(l)
     .setValue(0);
     
  background(240);
}


void draw() {
  background(240);
}

void dropdown(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));

  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */

  //CColor c = new CColor();
  //c.setBackground(color(255, 0, 0));
  //cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
}