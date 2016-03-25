class EncodedLetter {
  int[][] letterCode;

  EncodedLetter(int[] topCode, int[] bottomCode) {
    letterCode = new int[4][4];
    for (int i = 0; i < topCode.length; i++) {
      if (i < 4){
        letterCode[0][i] = topCode[i];
        letterCode[2][i] = bottomCode[i];
      } else {
        letterCode[1][i%4] = topCode[i];
        letterCode[3][i%4] = bottomCode[i];
      }
    }
  }
}