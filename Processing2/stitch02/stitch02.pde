
PImage grass, grass2;
int defaultSampleDimension = 96;
int defaultSampleOverlap   = defaultSampleDimension / 6;
int columns, rows;

ArrayList<ArrayList> samples = new ArrayList<ArrayList>();

void setup() {
  size(768, 768);

  columns = 1 + width / (defaultSampleDimension - defaultSampleOverlap);
  rows    = 1 + height / (defaultSampleDimension - defaultSampleOverlap);

  for (int i = 0; i < rows; i ++) {
    samples.add(new ArrayList<ImageSample>());
  }

  grass  = loadImage("grass.png");
  grass2 = loadImage("grass2.png");
}

void draw() {
  background(0);

  // 
  for (int i = 0; i < rows; i++) {
    ArrayList<ImageSample> row = samples.get(i);
    for (int j = 0; j < columns; j++) {
      int xOffset = i * (defaultSampleDimension - defaultSampleOverlap);
      int yOffset = j * (defaultSampleDimension - defaultSampleOverlap);
      ImageSample sample = getSample(grass2);

      // If this is the first sample, we don't need to do any overlapping.
      if (i == 0 && j == 0) {
        row.add(sample);
        continue;
      } else {
        // This is not the first sample, so we have to find the cutting edges
        row.add(sample);

        // We're on the first row but not at the first tile, 
        // so all that we need to do is the left overlap
        if (i == 0) {
          ImageSample s = row.get(j - 1);
          sample.performLeftOverlap(s);
          continue;
        }

        // We're not on the first row, but we're in the first column
        // so all that we need to do is the top overlap
        if (j == 0) {
          ArrayList<ImageSample> a = samples.get(i - 1);
          ImageSample s = a.get(0);
          sample.performTopOverlap(s);
          
        }
      }
    }
  }

  noLoop();
}


ImageSample getSample(PImage texture) {
  ImageSample samp = new ImageSample(texture);
  return samp;
}

