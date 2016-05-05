class ClickHandler {
 
  ClickHandler(){
    
  }
  
  // TODO: Remove - testing only.
  void placeDormRoomTemplate(){
    
    WorldCell wc = worldGrid.cellForPixels(mouseX,mouseY);
    // println(mouseX + ", " + mouseY + " --> " + wc.coords.x + ", " + wc.coords.y );
    
    int randIndex = int(random(0,database.dormRoomTemplates.size()));
    DormRoomTemplate drt = database.dormRoomTemplates.get(randIndex);
    drt.instantiateOnGridAt((int)wc.coords.x, (int)wc.coords.y);
    
    
  }
  
}