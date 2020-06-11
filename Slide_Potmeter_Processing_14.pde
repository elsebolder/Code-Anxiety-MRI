/*
Move a ball around the screen with an Ardunio;
 using two buttons for right and left and
 a potentiometer for up and down.
 by Lara Schenck
 http://notlaura.com/studioblog
 https://notlaura.com/move-a-ball-on-the-screen-with-arduino-processing/
 */
//https://www.youtube.com/watch?v=A_AFh1VZcSI&t=8s --> switch example

import processing.serial.*;
import cc.arduino.*;
import processing.pdf.*;

Arduino arduino;

// Set pins to variables
int potPin1 = 0;
int potPin2 = 1;
int potPin3 = 2; 
int potPin4 = 3;
int potPin5 = 4;
int potPin6 = 5;
int potPin7 = 6;

//button
int buttonPin = 12;
int outputA = 10;
int outputB = 11;

int counter = 0;
int aState;
int aLastState;
int buttonState = 0;
int counterThreshN = -20;
int thresDevide = 6;

// Variables to hold coordinates
int pot1Y = 0;
int pot2Y = 0;
int pot3Y = 0;
int pot4Y = 0;
int pot5Y = 0;
int pot6Y = 0;
int pot7Y = 0;

int corY1 = 0;
int corX1 = 0;

int circle1Y = 500;
int circle2Y = 500;
int circle3Y = 500;
int circle4Y = 500;
int circle5Y = 500;
int circle6Y = 500;

int circle1X = 500;
int circle2X = 700;
int circle3X = 900;
int circle4X = 1100;
int circle5X = 1300;
int circle6X = 1500;

//variabbles size

int sizeCircleS = 160;
//int sizeCircleL = 90;
//int sizeCircle;

//for the switch1
boolean sw1 = true;
boolean gate1 = false;
int sw1inc = 0;
int sw1total = 2;

//time
String timeString;
String hourString;
String minuteString;
String secondString;



//circles shapes
PShape circle1;
PShape circle2;
PShape circle3;
PShape circle4;
PShape circle5;
PShape circle6;

int circleHighlighted = 0;
boolean circleSelect = false;

PShape line1;

int potDevide = 7;
int movePot = 0;


void setup() {
  size(1920,1000); // Set screen size

  // Create arduino object
  arduino = new Arduino(this, Arduino.list()[0], 57600); 

  // Specify pin numbers as inputs
  arduino.pinMode(potPin1, Arduino.INPUT);
  arduino.pinMode(potPin2, Arduino.INPUT);
  arduino.pinMode(potPin3, Arduino.INPUT);
  arduino.pinMode(potPin4, Arduino.INPUT);
  arduino.pinMode(potPin5, Arduino.INPUT);
  arduino.pinMode(potPin6, Arduino.INPUT);
  arduino.pinMode(potPin7, Arduino.INPUT);

  arduino.pinMode(buttonPin, Arduino.INPUT);
  arduino.pinMode(outputA, Arduino.INPUT);
  arduino.pinMode(outputB, Arduino.INPUT);

  aLastState = arduino.digitalRead(outputA);
  dataSetup();
}

void draw() {
  background(255);   // Set the background to black
  lineMiddle();
  createCircle();
  move();// move should be first otherwise the selecting does not work
  rotaryPressed();
  switch1();
  selectCircle();
  highlightCircle();
  moveCircle();
  drawCircle();
  turn();
  time1();
  displacement();
  //data();
  //saveFrame1();
}

void lineMiddle() {
  line1 = createShape (LINE, 0, height/2, width, height/2);
  line1.setStroke(color(0));
  line1.setStrokeWeight (3);
  shape (line1);

  PFont font = createFont ("Calibri", 60);
  String textIm = "Niet belangrijk";
  textFont (font);
  textSize (26);
  textAlign (LEFT);
  text (textIm, 20, (height*0.25));

  String textNIm = "Belangrijk";
  //textFont (font);
  //textSize (15);
  textAlign (LEFT);

  text (textNIm, 20, (height*0.75));
}

void rotaryPressed() {
  if (arduino.digitalRead(buttonPin) == Arduino.LOW) {// if value is 1 (button pressed)
    gate1 = false;
  } else {
    gate1 = true;
  }
}

void switch1() {
  if (gate1) {
    if (sw1) {
      sw1 = false;
    }
  }
  if (!gate1) {
    if (!sw1) {
      sw1inc = (sw1inc + 1)% sw1total;
      println(sw1inc);
      sw1=true;
    }
  }
}

void createCircle() {
  circle1 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle2 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle3 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle4 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle5 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle6 = createShape(ELLIPSE, 0, 0, sizeCircleS, sizeCircleS);
  circle1.setFill(color(#C6ACC9));//blauw
  circle2.setFill(color(#ECB4BF));
  circle3.setFill(color(#FED6B5));
  circle4.setFill(color(#ABD8AC));
  circle5.setFill(color(#8699CE));
  circle6.setFill(color(#AEDFE3));
  circle1.setStroke(color(255));
  circle2.setStroke(color(255));
  circle3.setStroke(color(255));
  circle4.setStroke(color(255));
  circle5.setStroke(color(255));
  circle6.setStroke(color(255));
  
  // shape (circle1, corStartX1, circle1Y);
  // shape (circle2, corStartX1, circle2Y);
  // shape (circle3, corStartX1, circle3Y);
}


void selectCircle() {
  if (sw1inc == 1) {
    if (circleHighlighted == 1) {
      circle1.scale(1.2);
      circle1.setStroke(color(0));
    }
    if (circleHighlighted == 2) {
      circle2.scale(1.2);
      circle2.setStroke(color(0));
    }
    if (circleHighlighted == 3) {
      circle3.scale(1.2);
      circle3.setStroke(color(0));
    }
    if (circleHighlighted == 4) {
      circle4.scale(1.2);
      circle4.setStroke(color(0));
    }
    if (circleHighlighted == 5) {
      circle5.scale(1.2);
      circle5.setStroke(color(0));
    }
    if (circleHighlighted == 6) {
      circle6.scale(1.2);
      circle6.setStroke(color(0));
    }
  } else {
    if (circleHighlighted == 1) {
      circle1.scale(1);
    }
    if (circleHighlighted == 2) {
      circle2.scale(1);
    }
    if (circleHighlighted == 3) {
      circle3.scale(1);
    }
    if (circleHighlighted == 4) {
      circle4.scale(1);
    }
    if (circleHighlighted == 5) {
      circle5.scale(1);
    }
    if (circleHighlighted == 6) {
      circle6.scale(1);
    }
  }
}

void turn() {
  aState = arduino.digitalRead(outputA); // Reads the "current" state of the outputA
  // If the previous and the current state of the outputA are different, that means a Pulse has occured
  if (aState != aLastState) {
    // If the outputB state is different to the outputA state, that means the encoder is rotating clockwise
    if (arduino.digitalRead(outputB) != aState) {
      counter ++;
    } else {
      counter --;
    }
    if (counter < counterThreshN) {
      counter = 0;
    }
    if (counter > 0) {
      counter = 0;
    }
    //print("Position: ");
    //println(counter);
  }
  aLastState = aState; // Updates the previous state of the outputA with the current state
}

void highlightCircle() {
  //if ( counter <= 0 && counter > (counterThreshN/thresDevide) ) {
  //  circle1.setStroke(color(255, 255, 255));
  //}
  if (sw1inc == 0) {
    if ( counter <= 0 && counter > (counterThreshN/thresDevide) ) {//&& counter > (counterThreshN/7)
      circle1.setStroke(color(0));
      circle1.setStrokeWeight(2);
      circleHighlighted = 1;
    }
    if ( counter <= (counterThreshN/thresDevide) && counter > ((counterThreshN/thresDevide)*2) ) {//&& counter > (counterThreshN/7)
      circle2.setStroke(color(0));
      circle2.setStrokeWeight(2);
      circleHighlighted = 2;
    }
    if ( counter <= ((counterThreshN/thresDevide)*2) && counter >((counterThreshN/thresDevide)*3)) {//&& counter > (counterThreshN/7)
      circle3.setStroke(color(0));
      circle3.setStrokeWeight(2);
      circleHighlighted = 3;
    }
    if ( counter <= ((counterThreshN/thresDevide)*3) && counter >((counterThreshN/thresDevide)*4)) {//&& counter > (counterThreshN/7)
      circle4.setStroke(color(0));
      circle4.setStrokeWeight(2);
      circleHighlighted = 4;
    }
    if ( counter <= ((counterThreshN/thresDevide)*4) && counter >((counterThreshN/thresDevide)*5)) {//&& counter > (counterThreshN/7)
      circle5.setStroke(color(0));
      circle5.setStrokeWeight(2);
      circleHighlighted = 5;
    }
    if ( counter <= ((counterThreshN/thresDevide)*5) && counter >((counterThreshN/thresDevide)*6)) {//&& counter > (counterThreshN/7)
      circle6.setStroke(color(0));
      circle6.setStrokeWeight(2);
      circleHighlighted = 6;
    }
  }
}


void move() {
  pot1Y = arduino.analogRead(potPin1); // Get the potentiometer value
  pot1Y =constrain(pot1Y, 80, (height-80)); // Keep the ball on the screen

  pot2Y = arduino.analogRead(potPin2); // Get the potentiometer value
  pot2Y =constrain(pot2Y, 80, (height-80)); // Keep the ball on the screen

  pot3Y = arduino.analogRead(potPin3); // Get the potentiometer value
  pot3Y =constrain(pot3Y, 80, (height-80)); // Keep the ball on the screen

  pot4Y = arduino.analogRead(potPin4); // Get the potentiometer value
  pot4Y =constrain(pot4Y, 80, (height-80)); // Keep the ball on the screen

  pot5Y = arduino.analogRead(potPin5);
  pot5Y =constrain (pot5Y, 80, (height-80));

  pot6Y = arduino.analogRead(potPin6);
  pot6Y = constrain (pot6Y, 80, (height-80));

  pot7Y = arduino.analogRead(potPin7);
  pot7Y = constrain (pot7Y, 80, (height-80));
  
  movePot= (pot1Y/potDevide) + (pot2Y/potDevide) + (pot3Y/potDevide) + (pot4Y/potDevide) + (pot5Y/potDevide) + (pot6Y/potDevide) + (pot7Y/potDevide);

  //corX1 = width/2;
  //corY1 = 0 + (pot1Y/6) + (pot2Y/6) + (pot3Y/6) + (pot4Y/6) + (pot5Y/6) + (pot6Y/6) + (pot7Y/6);
  //ellipse (corX1, corY1, sizeCircle, sizeCircle);
  println(pot1Y);
  
}

void moveCircle() {
  

  if (circleHighlighted == 1 && sw1inc == 1) {
    circle1Y = movePot;
  }
  if (circleHighlighted == 2 && sw1inc == 1) {
    circle2Y = movePot;
  }
  if (circleHighlighted == 3 && sw1inc == 1) {
    circle3Y = movePot;
  }
  if (circleHighlighted == 4 && sw1inc == 1) {
    circle4Y = movePot;
  }
  if (circleHighlighted == 5 && sw1inc == 1) {
    circle5Y = movePot;
  }
  if (circleHighlighted == 6 && sw1inc == 1) {
    circle6Y = movePot;
  }
}

void drawCircle() {
  PFont font = createFont ("Calibri", 60);
  shape (circle1, circle1X, circle1Y);
  String text1 = "Informatie: veiligheid.";
  textFont (font);
  textSize (26);
  textAlign (CENTER, CENTER);
  text (text1, circle1X - 80, circle1Y -75, sizeCircleS, sizeCircleS);

  shape (circle2, circle2X, circle2Y);
  String text2 = "Geluid MRI horen.";
  fill(0);
 // textFont (font);
  //textSize (15);
  textAlign (CENTER, CENTER);
  text (text2, circle2X -80, circle2Y -75, sizeCircleS, sizeCircleS);

  shape (circle3, circle3X, circle3Y);
  String text3 = "Informatie: technische werking.";
 // textFont (font);
 // textSize (15);
  textAlign (CENTER, CENTER);
  text (text3, circle3X -80, circle3Y -75, sizeCircleS, sizeCircleS);

  shape (circle4, circle4X, circle4Y);
  String text4 = "Informatie: risico's.";
  //textFont (font);
  //textSize (20);
  textAlign (CENTER, CENTER);
  text (text4, circle4X -80, circle4Y -75, sizeCircleS, sizeCircleS);

  shape (circle5, circle5X, circle5Y);
  String text5 = "Effect magneten ervaren.";
 // textFont (font);
  //textSize (15);
  textAlign (CENTER, CENTER);
  text (text5, circle5X -80, circle5Y -75, sizeCircleS, sizeCircleS);

  shape (circle6, circle6X, circle6Y);
  String text6 = "Informatie: voorbereidingsstappen.";
  //textFont (font);
  //textSize (15);
  textAlign (CENTER, CENTER);
  text (text6, circle6X -80, circle6Y -75, sizeCircleS, sizeCircleS);
}

void time1() {
  int s = second();  // Values from 0 - 59
  int m = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  //println(h);
  //println(m);
  //println(s);
  if (h < 10)//if the time is for example 02:35:06, it normally would write 2:35:6 which might be unhandy when calculating. So the "0" is added.
  {
    hourString = "0" + h;
  } else {
    hourString = " " + h;
  }

  if (m < 10)
  {
    minuteString = "0" + m;
  } else {
    minuteString = " " + m;
  }

  if (s < 10)
  {
    secondString = "0" + s;
  } else {
    secondString = " " + s;
  }
  timeString = hourString + ":" + minuteString + ":" + secondString;
  //println(timeString);
}
