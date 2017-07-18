class Disease {
  int incubationTurns;
  int symptomaticTurns;
  int mortalityRate;
  String diseaseName;
 Disease(){
   this.incubationTurns  = int(random(0,3));
   this.symptomaticTurns = int(random(1,5));
   this.mortalityRate    = int(random(2,15));
   this.diseaseName      = "Hyena Flu";
 }
}