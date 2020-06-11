Table table;

// Generally, you should use "unsigned long" for variables that hold time
// The value will quickly become too large for an int to store
long previousMillis1 = 0;        // will store last time LED was updated
long interval1 = 100;           // interval at which to blink (milliseconds)
long previousMillis2 = 0;        // will store last time LED was updated
long interval2 = 500;           // interval at which to blink (milliseconds)

void dataSetup() {
  table = new Table();
  table.addColumn("id");
  table.addColumn("TimeElapsed");
  table.addColumn("Time");
  table.addColumn("Button");
  table.addColumn("Rotation");
  table.addColumn("Slider1");
  table.addColumn("Slider2");
  table.addColumn("Slider3");
  table.addColumn("Slider4");
  table.addColumn("Slider5");
  table.addColumn("Slider6");
  table.addColumn("Slider7");
  table.addColumn("PosCircle1");
  table.addColumn("PosCircle2");
  table.addColumn("PosCircle3");
  table.addColumn("PosCircle4");
  table.addColumn("PosCircle5");
  table.addColumn("PosCircle6");
  table.addColumn("DisplacementPot1");
  table.addColumn("DisplacementPot2");
  table.addColumn("DisplacementPot3");
  table.addColumn("DisplacementPot4");
  table.addColumn("DisplacementPot5");
  table.addColumn("DisplacementPot6");
  table.addColumn("DisplacementPot7");
}


void data() {
  long currentMillis = millis();
  if (currentMillis - previousMillis1 >= interval1) {
    // save the last time you saved data
    previousMillis1 = currentMillis;
    TableRow newRow = table.addRow();
    newRow.setInt("id", table.getRowCount() - 1);
    newRow.setLong("TimeElapsed", currentMillis);
    newRow.setString("Time", timeString);
    newRow.setInt("Button", sw1inc);
    newRow.setInt("Rotation", counter);
    newRow.setInt("Slider1", pot1Y);
    newRow.setInt("Slider2", pot2Y);
    newRow.setInt("Slider3", pot3Y);
    newRow.setInt("Slider4", pot4Y);
    newRow.setInt("Slider5", pot5Y);
    newRow.setInt("Slider6", pot6Y);
    newRow.setInt("Slider7", pot7Y);
    newRow.setInt("PosCircle1", circle1Y);
    newRow.setInt("PosCircle2", circle2Y);
    newRow.setInt("PosCircle3", circle3Y);
    newRow.setInt("PosCircle4", circle4Y);
    newRow.setInt("PosCircle5", circle5Y);
    newRow.setInt("PosCircle6", circle6Y);
    newRow.setInt("DisplacementPot1", displacementPot1);
    newRow.setInt("DisplacementPot2", displacementPot2);
    newRow.setInt("DisplacementPot3", displacementPot3);
    newRow.setInt("DisplacementPot4", displacementPot4);
    newRow.setInt("DisplacementPot5", displacementPot5);
    newRow.setInt("DisplacementPot6", displacementPot6);
    newRow.setInt("DisplacementPot7", displacementPot7);
    saveTable(table, "data/participant(filmpje)test.csv");
  }
}

void saveFrame1 () {
  long currentMillis = millis();
  if (currentMillis - previousMillis2 >= interval2) {
    // save the last time you saved data
    previousMillis2 = currentMillis;
    saveFrame("participant(Filmpje)test/Capture_########.png");
  }
}

// Sketch saves the following to a file called "new.csv":
// id,species,name
// 0,Panthera leo,Lion    
