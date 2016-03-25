class Encoder{
  color fillColor;
  int[][] numbers = {{1,1,1,1,0,1,1,1,1}, // 0
                     {1,1,1,0,1,0,0,1,0}, // 1
                     {0,1,0,0,1,0,1,1,1}, // 2
                     {1,0,0,1,1,1,1,0,0}, // 3
                     {0,0,1,1,1,1,0,0,1}, // 4
                     {1,1,1,1,0,1,1,0,1}, // 5
                     {1,0,1,1,0,1,1,1,1}, // 6
                     {1,1,1,1,0,0,1,1,1}, // 7
                     {1,1,1,0,0,1,1,1,1}, // 8
                     {1,1,1,1,0,0,1,0,1}, // 9
                     {1,1,1,0,0,1,1,0,1}, // A or 10
                     {1,0,1,1,0,0,1,1,1}, // B or 11
                     {1,0,1,0,0,1,1,1,1}, // C or 12
                     {0,0,1,1,1,1,1,0,0}, // D or 13
                     {1,0,0,1,1,1,0,0,1}, // E or 14
                     {1,0,1,0,1,0,1,0,1}};// F or 15
 
  Encoder(){
    fillColor = color(0);
  }
  
  void displayHexsetAt(int[] num, int scale, int xOffset, int yOffset){
    for(int i = 0; i < num.length; i++){
     pushMatrix();
     translate(xOffset,yOffset + (i * scale * 4)); // *4
     display(num[i],scale);
     popMatrix();
    }
  }
  
  void displayAt(int num, int scale, int xOffset, int yOffset){
   pushMatrix();
   translate(xOffset,yOffset);
   display(num,scale);
   popMatrix();
  }
  
  void display(int num, int scale){
    int[][] pixelMap = getRepresentation(num);
    
    noStroke();
    
    for (int y = 0; y < pixelMap.length; y++){
      for (int x = 0; x < pixelMap[y].length; x++) {
        int val = pixelMap[y][x];
        // print(val);
        int adjX = x * scale;
        int adjY = y * scale;
        int dim  = scale;
        
        if(pixelMap[y][x] == 1){
           fill(fillColor); 
        } else {
           fill(255);
        }
        
        rect(adjX,adjY,dim,dim);
      }
      // println();
    }
  }

  int[][] getRepresentation(int num){
    String hexString = String.format("%06X", num);
    
    IntList indices = new IntList();
    for(char c : hexString.toCharArray()){
        if (c == 'A') {
          indices.append(10);
        } else if (c == 'B'){
          indices.append(11);
        } else if (c == 'C'){
          indices.append(12);
        } else if (c == 'D'){
          indices.append(13);
        } else if (c == 'E'){
          indices.append(14);
        } else if (c == 'F'){
          indices.append(15);
        } else {
          // convert to int and use as index
          indices.append(Integer.parseInt("" + c));
        }
    }
    
    int[][] symbols = new int[6][9];
    
    for (int i = 0; i < indices.size(); i++){
      symbols[i] = numbers[indices.get(i)];
    }
    
    int[][] representation = new int[3][23];
    
    for (int i = 0; i < 3; i++){
      // Going through each row in the output
      for (int j = 0; j < symbols.length; j++){
        int rowOffset    = i*3;
        int symbolOffset = (j*3) + j;
        
        // Symbol pixel grid
        representation[i][symbolOffset]     = symbols[j][rowOffset];
        representation[i][symbolOffset + 1] = symbols[j][rowOffset + 1];
        representation[i][symbolOffset + 2] = symbols[j][rowOffset + 2];
        
        // Spacing between symbols
        // Make more flexible - don't hard code 23
        if(symbolOffset + 3 < 23){
          representation[i][symbolOffset + 3] = 0;
        }
      }
    }
    return representation;
  }
  

}