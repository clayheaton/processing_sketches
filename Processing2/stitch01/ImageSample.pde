class ImageSample {
  int defaultDimension = defaultSampleDimension;
  int defaultOverlap   = defaultSampleOverlap;

  PImage sample;
  int source_w, source_h;
  int w, h;
  int overlap;

  // CONSTRUCTORS
  ImageSample(PImage _source) {
    init(_source, defaultDimension, defaultDimension, defaultOverlap);
  }

  ImageSample(PImage _source, int _w, int _h, int _overlap) {
    init(_source, _w, _h, _overlap);
  }

  // INIT FUNCTION
  void init(PImage _source, int _w, int _h, int _overlap) {
    w        = _w;
    h        = _h;
    overlap  = _overlap;
    source_w = _source.width;
    source_h = _source.height;
    sample   = makeSample(_source);
  }



  PImage makeSample(PImage _source) {

    int start_x = int(random(0,source_w - w));
    int start_y = int(random(0,source_h - h));
    
    sample = _source.get(start_x,start_y,w,h);
    return sample;
    
  }
  
}

