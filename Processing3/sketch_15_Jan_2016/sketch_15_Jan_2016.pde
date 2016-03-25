
color[] colors;

Fungus fungus;

void setup(){
  size(600,600);
  
  colors = new color[] {
    //color(#F0F4F5),
    //color(#F7EDE3),
    //color(#FFF1CF),
    //color(#F4E6D9),
    color(#D8D6D7),
    color(#FFFFFF),
    color(#B3A79B),
    color(#75675A),
    color(#655845),
    color(#996E43),
    color(#7B5A2F),
    color(#8C653C),
    color(#6F4B2B),
    color(#5B3B22),
    color(#513C2D),
    color(#483324),
    color(#44352E),
    color(#3A2D24),
    color(#382A1F),
    color(#54402B),
    color(#6F5437),
    color(#856440),
    color(#9B7852),
    color(#9F814C),
    color(#AD8F53),
    color(#B39356),
    color(#CD9C64),
    color(#D4AD76),
    color(#AA875B)
  };
  
  fungus  = new Fungus(200,5);
  background(0);
}

void draw(){
  background(0);
  fungus.display();
  noLoop();
}