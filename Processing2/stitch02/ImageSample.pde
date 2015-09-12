class ImageSample {
  int defaultDimension = defaultSampleDimension;
  int defaultOverlap   = defaultSampleOverlap;

  PImage sample, leftOverlap, topOverlap;
  int source_w, source_h;
  int w, h;
  int overlap;

  OverlapGraph leftGraph, topGraph;

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
    makeOverlaps();
    makeLeftGraph();
    makeTopGraph();
  }

  PImage makeSample(PImage _source) {

    int start_x = int(random(0, source_w - w));
    int start_y = int(random(0, source_h - h));

    sample = _source.get(start_x, start_y, w, h);
    return sample;
  }

  // Draw from the sample to make the overlap
  void makeOverlaps() {
    leftOverlap  = sample.get(0, 0, overlap, sample.height);
    topOverlap   = sample.get(0, 0, sample.width, overlap);
  }

  void makeLeftGraph() {
    leftOverlap.loadPixels();
    leftGraph   = new OverlapGraph();
    leftGraph.xMax = leftOverlap.width - 1;
    leftGraph.yMax = leftOverlap.height - 1;

    int leftCounter = 0;

    for (int i = 0; i < leftOverlap.height; i++) {
      ArrayList<OverlapNode> overlapline = new ArrayList<OverlapNode>();

      for (int j = 0; j < leftOverlap.width; j++) {
        color argb = leftOverlap.pixels[leftCounter];

        int a = (argb >> 24) & 0xFF;
        int r = (argb >> 16) & 0xFF;   // Faster way of getting red(argb)
        int g = (argb >> 8)  & 0xFF;   // Faster way of getting green(argb)
        int b = argb & 0xFF;           // Faster way of getting blue(argb)

        OverlapNode o = new OverlapNode(r, g, b);

        // Set their positions
        o.x = j;
        o.y = i;

        overlapline.add(o);
        leftCounter += 1;
      }
      leftGraph.add(overlapline);
    }

    leftGraph.leftConnect();
  }

  void makeTopGraph() {
    topOverlap.loadPixels();
    topGraph      = new OverlapGraph();
    topGraph.xMax = topOverlap.width - 1;
    topGraph.yMax = topOverlap.height - 1;

    int topCounter = 0;

    for (int i = 0; i < topOverlap.height; i++) {
      ArrayList<OverlapNode> overlapline = new ArrayList<OverlapNode>();

      for (int j = 0; j < topOverlap.width; j++) {
        color argb = topOverlap.pixels[topCounter];

        int a = (argb >> 24) & 0xFF;
        int r = (argb >> 16) & 0xFF;   // Faster way of getting red(argb)
        int g = (argb >> 8)  & 0xFF;   // Faster way of getting green(argb)
        int b = argb & 0xFF;           // Faster way of getting blue(argb)

        OverlapNode o = new OverlapNode(r, g, b);

        // Set their positions
        o.x = j;
        o.y = i;

        overlapline.add(o);
        topCounter += 1;
      }
      topGraph.add(overlapline);
    }

    topGraph.topConnect();
  }

  // Only use this when on the top row and not in the left-most column
  void performLeftOverlap(ImageSample leftNeighbor) {
  }
  
  void performLeftOverlap(ImageSample leftNeighbor, ImageSample topLeftNeighbor){
    
  }

  // Only use this when in the first right column b/c there's no diagonal neighbor to update.
  void performTopOverlap(ImageSample topNeighbor) {
  }

  // Use when not on the first row and not in the right-most column.
  void performTopOverlap(ImageSample topNeighbor, ImageSample topRightNeighbor) {
    
  }
}

