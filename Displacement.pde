int beginPos1 = 0;
int beginPos2 = 0;
int beginPos3 = 0;
int beginPos4 = 0;
int beginPos5 = 0;
int beginPos6 = 0;
int beginPos7 = 0;
int displacementPot1 = 0;
int displacementPot2 = 0;
int displacementPot3 = 0;
int displacementPot4 = 0;
int displacementPot5 = 0;
int displacementPot6 = 0;
int displacementPot7 = 0;

long previousMillis3 = 0;        // will store last time LED was updated
int interval3 = 1000;           // interval at which to blink (milliseconds)


void displacement() {

  long currentMillis1 = millis();

  if (currentMillis1 - previousMillis3 >= interval3) {
    previousMillis3 = currentMillis1;
  }

  if (currentMillis1 - previousMillis3 == 0) {
    beginPos1 = pot1Y;
    beginPos2 = pot2Y;
    beginPos3 = pot3Y;
    beginPos4 = pot4Y;
    beginPos5 = pot5Y;
    beginPos6 = pot6Y;
    beginPos7 = pot7Y;
  }
  displacementPot1 =  pot1Y - beginPos1;
  displacementPot2 =  pot2Y - beginPos2;
  displacementPot3 =  pot3Y - beginPos3;
  displacementPot4 =  pot4Y - beginPos4;
  displacementPot5 =  pot5Y - beginPos5;
  displacementPot6 =  pot6Y - beginPos6;
  displacementPot7 =  pot7Y - beginPos7;
  
  //println(displacementPot1);

//println(currentMillis1);
}
