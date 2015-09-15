class Chart {
  int[][] chartData;
  int[]   activeData;
  int     seriesCount;
  int     activeSeriesNumber;
  int     maxValue;

  PVector chartOrigin;

  int     dimension; // The size of the chart, square

  Chart() {
    println("Please use the other constructor for Chart.");
  }

  Chart(int[][] data, PVector tChartOrigin, int tDimension) {
    chartData   = data; 
    activeData  = data[0];
    activeSeriesNumber = 0;
    seriesCount = data.length;
    chartOrigin = tChartOrigin;
    dimension   = tDimension;

    maxValue    = 0;
    println("Chart initialized with " + seriesCount + " series.");

    setMaxValue();
  }

  void nextSeries() {
    int series;
    if (activeSeriesNumber == seriesCount - 1) {
       series = 0; 
    } else {
       series = activeSeriesNumber + 1; 
    }
    
    activeSeriesNumber = series;
    
    activeData = data[activeSeriesNumber];
    
    setMaxValue();
  }

  void setMaxValue() {
    int x = activeData[0];
    for (int i = 1; i < activeData.length; i++) {
      if (activeData[i] > x) {
        x = activeData[i];
      }
    } 
    maxValue = x;
    println("Chart's max value for this series is " + maxValue);
  }

  void display() {
    drawYAxis();
    drawXAxis();
    drawBars();
  }

  void drawYAxis() {
    stroke(100);
    line(chartOrigin.x, chartOrigin.y + dimension, chartOrigin.x, chartOrigin.y);

    // Top cross line on y-axis
    line(chartOrigin.x - 5, chartOrigin.y + 5, chartOrigin.x + 5, chartOrigin.y + 5);

    // Add the label
    fill(0);
    text(maxValue, chartOrigin.x - 7, chartOrigin.y + 10);

    // Mid cross line
    line(chartOrigin.x - 5, chartOrigin.y + (dimension * 0.5), chartOrigin.x + 5, chartOrigin.y + (dimension * 0.5));
    text(nf((maxValue * 0.5), 1, 1), chartOrigin.x - 7, chartOrigin.y + (dimension * 0.5) + 10);

  }
  
  void drawXAxis() {
    line(chartOrigin.x, chartOrigin.y + dimension, chartOrigin.x + dimension, chartOrigin.y + dimension); 
  }
  
  void drawBars() {
    // Determine bar width
    float barW = dimension / activeData.length;
    barW -= 2;
    
    rectMode(CORNER);
    
    noStroke();
    fill(128);
    for (int i = 0; i < activeData.length; i++) {
       // Normalize the size of the bar
       float barHeight = (((float)activeData[i] / maxValue) * dimension) - 5;
       float offsetFromTop = dimension - barHeight;
       
       float xPos = chartOrigin.x + 2 + (i * barW);
       rect(xPos, chartOrigin.y + offsetFromTop, barW - 2, barHeight);
    }  
  }
}

