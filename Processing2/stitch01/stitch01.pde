/* Stitch 01 is an example of tiling without stitching to minimize
   errors at the points of overlap between tiles */

PImage grass, grass2;
int defaultSampleDimension = 96;
int defaultSampleOverlap   = defaultSampleDimension / 6;
int columns, rows;

void setup() {
  size(768, 768);

  columns = 1 + width / (defaultSampleDimension - defaultSampleOverlap);
  rows    = 1 + height / (defaultSampleDimension - defaultSampleOverlap);

  grass  = loadImage("grass.png");
  grass2 = loadImage("grass2.png");
}

void draw() {
  background(0);

  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      int xOffset = i * (defaultSampleDimension - defaultSampleOverlap);
      int yOffset = j * (defaultSampleDimension - defaultSampleOverlap);
      
      ImageSample sample = new ImageSample(grass); 
      
      if(random(1) > 0.1) {
       sample = new ImageSample(grass2);
      }
      
      PImage s = sample.sample;
      image(s, xOffset, yOffset);
    }
  }

  noLoop();
}

