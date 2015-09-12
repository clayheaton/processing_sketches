class Sample {
  PImage sample;

  Sample(PImage _source) {
    int sample_x_start = int(random(0,_source.width  - sampleSize));
    int sample_y_start = int(random(0,_source.height - sampleSize));
    sample = _source.get(sample_x_start,sample_y_start,sampleSize,sampleSize);
  }
}

