class WangColorSample {
  PVector ul, ur, lr, ll;
  int size;
  String colorname;
  color c;
  Sample imageSample;
  
  WangColorSample(PImage _source, String _colorname, int _size) {
    imageSample = new Sample(_source,_size);
    colorname   = _colorname;
    size        = _size;
  }
}

