/************************************************************************
 * Copyright: Geko Navsat
 * Project: Kyneo
 * File: Kyneo_GUI.pde
 * Date (YY/MM/DD): 15/08/02
 ************************************************************************/

/*************************************************************************
 * PROGRAM DESCRIPTION
 *
 * Name: Kyneo_GUI
 * Language: Processing
 * Type: Processing Program
 * 
 * Purpose:
 *   The purpose of the Kyneo_GUI program is to create a graphic interface
 *   interface to graphically show the data transmitted through the serial
 *   port.
 *
 * Function:
 *
 * Dependencies:
 *
 * Files modified:
 *
 * Files read:
 *
 *************************************************************************/

/*********************************
 *
 *        RELEASE HISTORY
 *
 *---------------------------------
 * Date:     15/07/29
 * Version:  v0.0.1
 * Comments: Initial Release
 *---------------------------------
 *
 *********************************/

/*********************************
 * Library imports
 *********************************/
 
 /* Processing libraries */
 /* Serial library */
 import processing.serial.*;
 
 /* Core library */
 import processing.core.*;

 /* Unfolding libraries */
 import de.fhpotsdam.unfolding.mapdisplay.*;
 import de.fhpotsdam.unfolding.utils.*;
 import de.fhpotsdam.unfolding.marker.*;
 import de.fhpotsdam.unfolding.tiles.*;
 import de.fhpotsdam.unfolding.interactions.*;
 import de.fhpotsdam.unfolding.ui.*;
 import de.fhpotsdam.unfolding.*;
 import de.fhpotsdam.unfolding.core.*;
 import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
 import de.fhpotsdam.unfolding.data.*;
 import de.fhpotsdam.unfolding.geo.*;
 import de.fhpotsdam.unfolding.texture.*;
 import de.fhpotsdam.unfolding.events.*;
 import de.fhpotsdam.utils.*;
 import de.fhpotsdam.unfolding.providers.*;
 import de.fhpotsdam.unfolding.geo.Location;
 import de.fhpotsdam.unfolding.marker.SimplePointMarker;
 import de.fhpotsdam.unfolding.providers.*;
  
 /* Java I/O library */
 import java.io.*;
 
 /* Java Math library */
 import java.math.*;
 
 /* External Java classes */
 /* None */

/*********************************
 * Objects and constants
 *********************************/
  
  /* Processing Font */
  PFont font;
  
  /* Serial port */
  Serial myPort;
  
  /* Unfolding map */
  UnfoldingMap map;
  
  /* Window size */
  /* Width */
  final int iWindowSizeX = 1300;
  /* Height */
  final int iWindowSizeY = 700;

  /* Line feed */
  /*  Text   ASCII */
  /*  '\n'    10   */
  int iLf = 10;
  
  /* Initial map location and panning */
  Location locInitialLocation = new Location(40.3546f, -3.7432f);
  int iInitialPanning = 16;
  
  

/*********************************
 * Variables declaration
 *********************************/
  
  /* Quaternions */
  float [] fQ = new float [4];
  
  /* Home quaternion */
  float [] fHq = null;
  
  /* Coordinates */
  float fLat;
  float fLon;
  
  /* North - South hemispheres */
  boolean bNorth = true;
  boolean bSouth = false;
  
  /* East - West hemispheres */  
  boolean bEast = false;
  boolean bWest = true;
  
  /* Altitude */
  float fAlt;
  
  /* Temperature*/
  float fTemp;
 
  /* Pressure */
  float fPres;
  
  /* Euler angles
   * psi, theta, phi */
  float [] fEuler = new float [3]; /* psi, theta, phi */
  
  /* Yaw, pitch, roll */
  float [] fYpr = new float [3]; /* yaw, pitch, roll */

  /* Incoming buffer
   * Size of number of chars on each line from the Arduino
   * including /r and /n                                   */
  byte[] bInBuffer = new byte[22];
  
  /* Received string */
  String sReceivedString;
  
/*********************************
 * System Flags
 *********************************/
  
  /* GPRMC update processed
   * Upped when a new $GPRMC sentence has been received and
   * is to be printed      
   */
  boolean UPDATE_GPRMC;
  
  /* Q update processed
   * Upped when a new $Q sentence has been received and
   * is to be printed
   */
  boolean UPDATE_Q;

  /* BARO update processed 
   * Upped when a new $BARO sentence has been received and
   * is to be printed
   */
  boolean UPDATE_BARO;
  
/*********************************
 * System variables
 *********************************/
  /* Debugging mode: activates sentences error prints
   * FALSE -> Inactive
   * TRUE -> Active
   */
  boolean debug = false;
  
  /* Verbose mode: print processed sentences
   * False -> Inactive
   * TRUE -> Active
   */
  boolean verbose = false;
  
/******************************************************************************
 * Description: The setup() function is called once when the program starts. 
 *   It's used to define initial enviroment properties such as screen size and 
 *   background color and to load media such as images and fonts as the program 
 *   starts.
 *
 * Parameters  :
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *****************************************************************************/
void setup() 
{
  /* Defines dimension of the display and rendering engine to use */
  size(iWindowSizeX, iWindowSizeY, P3D);                                            
  
  /* If there are no serial ports in the list, print a message and wait until 
   * there is an available serial port in the list   
   */
  if (Serial.list().length == 0){
    
    /* Print text on console */
    println("No serial ports found. Plug in Kyneo.");
    
    while (Serial.list().length == 0){}
    
  }
  
  /* Open first port of the list of all available serial ports with a baudrate
   * of 57600 bauds
   */
  myPort = new Serial(this, Serial.list()[0], 57600);
  
  /* Configure port to read until the lf ("\n" in this case) is received */
  myPort.bufferUntil(iLf);
  
  /* Load the font to be used */
  font = loadFont("CourierNew36.vlw"); 
  
  /* Configure map */
  /* Constructor summary                     */
  /* UnfodingMap (processing.core.PApplet p, 
                  float x, 
                  float y, 
                  float width, 
                  float height, 
                  java.lang.String renderer) */
  map = new UnfoldingMap (this, /* reference to current object */
                          iWindowSizeX / 2 + 10, /* x coordinate for map */
                          iWindowSizeY / 2 + 10, /* y coordinate for map */
                          iWindowSizeX / 2 - 20, /* map width */
                          iWindowSizeY / 2 - 20, /* map height */
                          new Microsoft.AerialProvider()); /* map provider */
                          
  /* Configure event dispatcher */
  MapUtils.createDefaultEventDispatcher(this, map);
  
  /* Configure initial map visualization */  
  map.zoomAndPanTo(locInitialLocation, iInitialPanning);
  
  /* Configure panning restriction */
  //map.setPanningRestriction(new Location(40.3546f, -3.7432f), 30);
  
  
  /* Flags initialization if verbose mode is active */
  if (verbose){
    UPDATE_GPRMC = false;
    UPDATE_Q = false;
    UPDATE_BARO = false;
  }
  
  /* Delay to allow for initialization */
  delay(100);
  
  /* Clear serial port */
  myPort.clear();
  
  /* Stop Processing from continuously executing the code within draw() */
  noLoop();
}

/******************************************************************************
 * Description: The decodeFloat function takes a string of 8 characters 
 *   and converts it to a float number.
 * Parameters  :
 *   Name                           |D|Unit|            Description
 *   inString                        I N/A  8 characters string to be converted
 *   return                          O N/A  Float after decoding inString
 ******************************************************************************/
float decodeFloat(String inString) {
  
  /* Variable declaration */
  byte [] inData = new byte[4];
  
  /* if input string has 8 characters, convert inString to float */
  if(inString.length() == 8) {
    inData[0] = (byte) unhex(inString.substring(0, 2));
    inData[1] = (byte) unhex(inString.substring(2, 4));
    inData[2] = (byte) unhex(inString.substring(4, 6));
    inData[3] = (byte) unhex(inString.substring(6, 8));
  }
  
  int intbits = (inData[3] << 24) | 
                ((inData[2] & 0xff) << 16) |
                ((inData[1] & 0xff) << 8) |
                (inData[0] & 0xff);
  
  return Float.intBitsToFloat(intbits); /* 0 returned string length is not 8 */
}

/*******************************************************************************
 * Description: This function is called everytime data is available through the
 *   serial port.
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/
void serialEvent(Serial p) {
  
  /* sInputString variable is filled with the data */
  /* received through the serial port             */
  String sInputString = p.readString();  
  
  /* Check for sInputString not empty. If it is not, */
  /* proceed to decode the received data            */
  if (sInputString != null && sInputString.length() > 0) {
  
    /* The data received is unpacked. sInputString contains different pieces of data separated */ 
    /* by commas. sInputString is separated into an array of strings, each of which containing */ 
    /* one piece of data                                                                      */
    String [] sInputStringArr = split(sInputString, ",");
    
    /* If the data received is a GPRMC sentence, decode the coordinates */
    if (sInputStringArr[0].equals("$GPRMC") || sInputStringArr[0].equals("$GNRMC")){
      
      /* GPRMC sentences are 12 fields long. If a received GPRMC sentence is shorter than
       * that, an error is thrown
       */
      if (sInputStringArr.length >= 12){
          
        /* Check if coordinates were acquired */
        if ((sInputStringArr[3] != null && !sInputStringArr[3].isEmpty()) 
             && (sInputStringArr[5] != null && !sInputStringArr[5].isEmpty())){
          
          /* Clear received string variable */
          sReceivedString = null;
               
          /* Store input string into received string variable */
          sReceivedString = sInputString;
               
          /* GPS coordinates are decoded and latitude and longitude variables are filled
           * Format: +(N,W)/-(S,E) DDMM.MM 
           */
          fLat = float(sInputStringArr[3]) * pow(-1, int((sInputStringArr[4].equals("S"))));
          fLon = float(sInputStringArr[5]) * pow(-1, int((sInputStringArr[6].equals("W"))) );
          
          /* Calculate location hemispheres */
          if (sInputStringArr[4].equals("S")){
            bNorth = false;
            bSouth = true;
          } else {
            bNorth = true;
            bSouth = false;
          }
          if(sInputStringArr[6].equals("W")){
            bEast = false;
            bWest = true;
          } else {
            bEast = true;
            bWest = false;
          }
        
          /* Convert coordinates from degrees, minutes to decimal  
           * Format: +(N,W)/-(S,E) decimal coordinates 
           */
          coordDM2Dec(fLat, fLon);
        
          /* New data decoded is feed to the map, creating a location and a marker */
          addLocation(fLat, fLon);
               
          /* Flag of new GPRMC sentence to be printed is upped if verbose mode is
           * active
           */
          if(verbose){
            UPDATE_GPRMC = true;
          }          
        }
      }        
      else{
        
        /* Print incomplete $GPRMC error message (debug)*/
        if (debug){
          println("Incomplete $GPRMC sentece received. Sentence discarded.");
        } 
      }
      
    /* If the data received is a Q sentence, decode the quaternions and the heading */
    } else if (sInputStringArr[0].equals("$Q")){
      
      /* Q sentences are 6 fields long. If a received Q sentence is shorter than
       * that, an error is thrown                                                        
       */      
      if (sInputStringArr.length >= 6){
          
        /* Clear received string variable */
        sReceivedString = null;
               
        /* Store input string into received string variable */
        sReceivedString = sInputString;        
        
        /* Quaternions and heading are decoded and the respective variables are filled  */
        fQ[0] = decodeFloat(sInputStringArr[1]);
        fQ[1] = decodeFloat(sInputStringArr[2]);
        fQ[2] = decodeFloat(sInputStringArr[3]);
        fQ[3] = decodeFloat(sInputStringArr[4]);
        
        /* Flag of new Q sentence to be printed is upped if verbose mode is
         * active
         */
        if(verbose){
          UPDATE_Q = true;
        } 
      } else {
        
        /* Print incomplete $Q error message (debug) */
        if (debug){
          println("Incomplete $Q sentece received. Sentence discarded.");
        } 
      }
      
    /* If the data received is a BARO sentence, decode pressure, temperature and altitude */
    } else if (sInputStringArr[0].equals("$BARO")){
      
      /* BARO sentences are 7 fields long. If a received BARO sentence is shorter than
       * that, an error is thrown                                                        
       */
      if (sInputStringArr.length >= 4){
        
        /* Clear received string variable */
        sReceivedString = null;
               
        /* Store input string into received string variable */
        sReceivedString = sInputString;
        
        /* Decoded values are stored in their respective variables */
        //fPres = decodeFloat(sInputStringArr[1]);
        fPres=1024; 
        //fTemp = decodeFloat(sInputStringArr[2]);
        fTemp=18.2;
        //fAlt = decodeFloat(sInputStringArr[3]);
        fAlt=660.7;
        
        /* Flag of new BARO baro to be printed is upped if verbose mode is
         * active
         */
        if(verbose){
          UPDATE_BARO = true;
        }
      } else {
        
        /* Print incomplete $BARO error message (debug)*/
        if (debug){
          println("Incomplete $BARO sentece received. Sentence discarded.");
        }   
      }
      
    /* If the data received doesn't have a valid header, an error is thrown
     * (debug)
     */
    } else {
      if (debug){
        println("Sentence with no recognized header received. Sentence discarded.");
      }
    }
  }
  
  /* Update the display window */
  redraw();
}

/*******************************************************************************
 * Description: This function creates the shape of the box to be used to 
 *   represent the Kyneo device.
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/

void buildBoxShape() {
  
  /* Outline drawing disabled */
  noStroke();
  
  /* Begin recording vertices for the shape
   * QUADS -> Quadrilaterals (four sided polygons)
   */
  beginShape(QUADS);
  
  /* Front face (Z+) 
   * Color: Light green
   */
  fill(0, 255, 0);
  vertex(-30, -5, 20);
  vertex(30, -5, 20);
  vertex(30, 5, 20);
  vertex(-30, 5, 20);
  
  /* Back face (Z-)
   * Color: Blue
   */
  fill(0, 0, 255);
  vertex(-30, -5, -20);
  vertex(30, -5, -20);
  vertex(30, 5, -20);
  vertex(-30, 5, -20);
  
  /* Left side (X-)
   * Color: Red
   */
  fill(255, 0, 0);
  vertex(-30, -5, -20);
  vertex(-30, -5, 20);
  vertex(-30, 5, 20);
  vertex(-30, 5, -20);
  
  /* Right side (X+)
   * Color: Yellow
   */
  fill(255, 255, 0);
  vertex(30, -5, -20);
  vertex(30, -5, 20);
  vertex(30, 5, 20);
  vertex(30, 5, -20);
  
  /* Top face (Y-)
   * Color: Purple
   */
  fill(255, 0, 255);
  vertex(-30, -5, -20);
  vertex(30, -5, -20);
  vertex(30, -5, 20);
  vertex(-30, -5, 20);
  
  /* Botton face (Y+)
   * Color: Light blue
   */
  fill(0, 255, 255);
  vertex(-30, 5, -20);
  vertex(30, 5, -20);
  vertex(30, 5, 20);
  vertex(-30, 5, 20);
  
  /* Finish recording vertices for the shape */
  endShape();
}

/*******************************************************************************
 * Description: This function draws the box representing Kyneo with its 
 *   orientation.
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/

void drawPrism() {
  
  /* Push Matrix (modify grid until popMatrix is called)  */
  pushMatrix();
    
    /* Translate grid to center of rotation of the prism */
    translate(iWindowSizeX / 4, iWindowSizeY / 2, 0);
    
    /* Change size of grid */
    scale(5,5,5);
    
    /* Grid size change to compensate for vanishing point */
    scale(1,1,0.01);
    
    /* Grid rotation
     * Rotation order: roll, pitch, yaw
     */
    rotateZ(-fEuler[2]); /* phi - roll */
    rotateX(-fEuler[1]); /* theta - pitch */
    rotateY(-fEuler[0]); /* psi - yaw */
    
    /* Draw the box */
    buildBoxShape();
  
  /* Pop Matrix (restore grid) */  
  popMatrix();
}


/*******************************************************************************
 * Description: This function continuously executes the lines of code contained
 *   inside its block until the program is stopped.
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/

void draw() {
  background(#000000);
  
  /* If verbose mode is active, print the Q, BARO or GPRMC processed sentece */
  if (verbose){
    if (UPDATE_Q){
      println(sReceivedString);
    }
  
    if (UPDATE_BARO){
      println(sReceivedString);
    }
  
    if (UPDATE_GPRMC){
      println(sReceivedString);
    }
  }
  
  /* Use home quaternion if it has been defined */ 
  if(fHq != null) {
    
    /* Display text with instructions to disable home quaternion as reference */
    text("Disable home position by pressing \"n\"", /* Text to display */
         20, /* x coordinate (position) */
         iWindowSizeY - 30); /* y coordinate (position) */
         
    /* Convert quaternion to euler angles using home quaternion as reference */
    quaternionToEuler(quatProd(fHq, fQ), fEuler);
    
  }
  else {
        
    /* Display text with instructions to enable home quaternion as reference */
    text("Point FreeIMU's X axis to your monitor then press \"h\"", /* Text */ 
         20, /* x coordinate (position) */
         iWindowSizeY - 30); /* y coordinate (position) */
    
    /* Convert quaternion to euler angles */
    quaternionToEuler(fQ, fEuler);
  }
  
  /* Calculate estimated yaw, pitch and roll */
  getYawPitchRoll();
  
  /* Configure text boxes 
   * Transparent boxes
   */
  noFill();
  
  /* Configure boxes line weight */
  strokeWeight(6);
  
  /* Configure boxes line color */
  stroke(204, 102, 0);
  
  /* Draw text boxes 
   * Quaternion text box
   */
  rect(iWindowSizeX / 2 + 10, /* x coord of the rectangle*/
       30, /* y coord of the rectangle */
       iWindowSizeX / 2 - 20, /* rectangle width */
       40, /* rectangle height */
       7); /* radii for all four corners */
       
  /* Pressure, temperature and altitude box */
  rect(iWindowSizeX / 2 + 10, /* x coord of the rectangle*/
       90, /* y coord of the rectangle */
       iWindowSizeX / 4 - 17, /* rectangle width */
       120, /* rectangle height */
       7); /* radii for all four corners */
  
  /* Yaw, pitch, roll box */
  rect(3 * iWindowSizeX / 4 + 7, /* x coord of the rectangle*/
       90, /* y coord of the rectangle */
       iWindowSizeX / 4 - 17, /* rectangle width */
       120, /* rectangle height */
       7); /* radii for all four corners */
       
  /* Euler angles box */
  rect(iWindowSizeX / 2 + 10, /* x coord of the rectangle*/
       230, /* y coord of the rectangle */
       iWindowSizeX / 2 - 20, /* rectangle width */
       40, /* rectangle height */
       7); /* radii for all four corners */
  
  /* GPS box */
  rect(iWindowSizeX / 2 + 10, /* x coord of the rectangle*/
       290, /* y coord of the rectangle */
       iWindowSizeX / 2 - 20, /* rectangle width */
       40, /* rectangle height */
       7); /* radii for all four corners */
       
  /* Configure text size */
  textSize(18);
  
  /* Configure text color */
  fill(255, 255, 255); /* white */
  
  /* Draw required text to display window 
   * Quaternion text
   */
  text("Q: " + fQ[0] + ", " + fQ[1] + ", " + fQ[2] + ", " + fQ[3], /* text */ 
       iWindowSizeX / 2 + 20, /* x position (coordinate) */
       55); /* y position (coordinate) */
  /* Pressure, temperature and altitude text */
  text("Pressure: " + fPres + "hPa\nTemperature: " + fTemp + "ºC\nAltitude: " + fAlt + "m", /* text */
       iWindowSizeX / 2 + 20, /* x position (coordinate) */
       125); /* y position (coordinate) */
  
  /* Yaw, pitch and roll text */
  text("Yaw: " + fYpr[0] + "\nPitch: " + fYpr[1] + "\nRoll: " + fYpr[2],
       3 * iWindowSizeX / 4 + 20, /* x position (coordinate) */
       125); /* y position (coordinate) */
  
  /* Euler angles text */
  text("Euler angles (rad): " + fEuler[0] + ", " + fEuler[1] + ", " + fEuler[2], /* text */
       iWindowSizeX / 2 + 20, /* x position (coordinate) */
       255); /* y position (coordinate) */
  
  /* GPS text */
  if (bNorth){
    text("Latitude: " + fLat + " N", /* text */
         iWindowSizeX / 2 + 20, /* x position (coordinate) */
         315); /* y position (coordinate) */
  } else {
    text("Latitude: " + (-fLat) + " S", /* text */
         iWindowSizeX / 2 + 20, /* x position (coordinate) */
         315); /* y position (coordinate) */
  }
  if (bEast){
    text("Longitude: " + fLon + " E", /* text */
         3 * iWindowSizeX / 4, /* x position (coordinate) */
         315); /* y position (coordinate) */
  } else {
    text("Longitude: " + (-fLon) + " W", /* text */
         3 * iWindowSizeX / 4, /* x position (coordinate) */
         315); /* y position (coordinate) */
  }
  
  /* Draw Kyneo prism */
  drawPrism();
    
  /* Draw map */
  map.draw();
    
  /* After all the required updating operations are done, the flags 
   * for updating are downed. Only done if verbose mode is active
   */
  if(verbose){
    UPDATE_GPRMC = false;
    UPDATE_Q = false;
    UPDATE_BARO = false;
  }
}

/*******************************************************************************
 * Description: This function is called once everytime a key is pressed. The 
 *   pressed key is stored inthe key variable.
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/
void keyPressed() {
  
  /* If key 'h' is pressed, the conjugate of the quaternion at the moment is set
   * as home quaternion and stored in the fHq variable.
   */
  if(key == 'h') {
    
    /* Print event message */
    println("Key 'h' pressed");
    
    /* Store the conjugate of the quaternion of the moment as home quaternion */
    fHq = quatConjugate(fQ);
    
    /* Execute draw function */
    redraw();
  }
  
  /* If key 'n' is pressed, stop using the value of fHq as the conjugate of home
   * quaternion.
   */
  else if(key == 'n') {
    
    /* Print event message */
    println("Key 'n' pressed");
    
    /* Empty home quaternion */
    fHq = null;
    
    /* Execute draw function */
  }
  
  /* If key 'q' is pressed, stop the program */
  else if(key == 'q') {
    
    /* Stop the program */
    exit();
  }
}

/*******************************************************************************
 * Description: This function converts quaternions to Euler angles.
 * Original Author: Sebastian Madgwick
 * Modified by: Carmelo Hernandez
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   fQ                              I N/A  Quaternions array
 *   fEuler                          I N/A  Euler angles array
 *******************************************************************************/
void quaternionToEuler(float [] fQ, float [] fEuler) {
  /* psi - yaw */
  fEuler[0] = atan2(2 * fQ[1] * fQ[2] - 2 * fQ[0] * fQ[3], 2 * fQ[0]*fQ[0] + 2 * fQ[1] * fQ[1] - 1);
  
  /* pitch - theta */
  fEuler[1] = -asin(2 * fQ[1] * fQ[3] + 2 * fQ[0] * fQ[2]);
  
  /* roll - phi */
  fEuler[2] = atan2(2 * fQ[2] * fQ[3] - 2 * fQ[0] * fQ[1], 2 * fQ[0] * fQ[0] + 2 * fQ[3] * fQ[3] - 1);
}

/*******************************************************************************
 * Description: This function returns the multiplication of two quaternions.
 * Author: Sebastian Madgwick
 * Modified by: Carmelo Hernandez
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   fA                              I N/A  A quaternion
 *   fB                              I N/A  B quaternion
 *   fQ                              O N/A  Result of the A and B multiplication
 *******************************************************************************/
float [] quatProd(float [] fA, float [] fB) {
  
  /* Variable declaration */
  float [] fQ = new float[4];
  
  /* Multiplication calculations */
  fQ[0] = fA[0] * fB[0] - fA[1] * fB[1] - fA[2] * fB[2] - fA[3] * fB[3];
  fQ[1] = fA[0] * fB[1] + fA[1] * fB[0] + fA[2] * fB[3] - fA[3] * fB[2];
  fQ[2] = fA[0] * fB[2] - fA[1] * fB[3] + fA[2] * fB[0] + fA[3] * fB[1];
  fQ[3] = fA[0] * fB[3] + fA[1] * fB[2] - fA[2] * fB[1] + fA[3] * fB[0];
  
  /* Output resulting quaternion */
  return fQ;
}

/*******************************************************************************
 * Description: This function returns the quaternion conjugate.
 * Author: Sebastian Madgwick
 * Modified by: Carmelo Hernandez
 * Parameters:
 *   Name                           |D|Unit|            Description
 *   fQuat                           I N/A  Quaternion input
 *   fConj                           O N/A  Quaternion conjugate
 *******************************************************************************/
float [] quatConjugate(float [] fQuat) {
  
  /* Variable declaration */
  float [] fConj = new float[4];
  
  /* Quaternion conjugate calculations */
  fConj[0] = fQuat[0];
  fConj[1] = -fQuat[1];
  fConj[2] = -fQuat[2];
  fConj[3] = -fQuat[3];
  
  /* Output quaternion conjugate */
  return fConj;
}

/*******************************************************************************
 * Description: This function converts latitude and longitude coordinates from
 *   DDMM.MM format to decimal format.
 * Parameters:
 *   Name                   |D|Unit     |            Description
 *   fLatitude               I DDMM.MMMM Latitude coordinate in DDMM.MM format
 *   fLongitude              I DDMM.MMMM Longitude coordinate in DDMM.MM format
 *******************************************************************************/
void coordDM2Dec (float fLatitude, float fLongitude){
  
  /* Minutes are converted to degrees and added to the degrees */
  fLat = (int)fLatitude / 100 + fLatitude % 100 / 60;
  fLon = (int)fLongitude / 100 + fLongitude % 100 / 60;
}

/*******************************************************************************
 * Description: This function adds a new location, creates a marker for that 
 *   location and adds it to the map.
 * Parameters:
 *   Name                         |D|Unit|            Description
 *   fLat                          I dec  Latitude coordinate in decimal format
 *   fLon                          I dec  Longitude coordinate in decimal format
 *******************************************************************************/
void addLocation (float fLat, float fLon){
  
  /* Add location */
  Location newLocation = new Location(fLat, fLon);
  
  /* Add point marker for location newLocation */
  SimplePointMarker newMarker = new SimplePointMarker(newLocation);
  
  /* Add marker to map */
  map.addMarkers(newMarker);
  
  /* Center map at newLocation */
  map.zoomAndPanTo(newLocation, iInitialPanning);
}

/*******************************************************************************
 * Description: This function obtains yaw, pitch and roll from the quaternion
 *   stored at fQ.
 * Author: mjs513
 * Modified by: Carmelo Hernández
 * Parameters:
 *   Name                         |D|Unit|            Description
 *   -----------------------------NONE-----------------------------
 *******************************************************************************/
void getYawPitchRoll() {
   /* Estimated gravity direction */
  float fGx, fGy, fGz;
  
  /* Perform calculations to obtain estimated gravity direction */
  fGx = 2 * (fQ[1]*fQ[3] - fQ[0]*fQ[2]);
  fGy = 2 * (fQ[0]*fQ[1] + fQ[2]*fQ[3]);
  fGz = fQ[0]*fQ[0] - fQ[1]*fQ[1] - fQ[2]*fQ[2] + fQ[3]*fQ[3];
  
  /* Perform calculations to obtain estimated yaw, pitch and roll */
  fYpr[0] = degrees(atan2(2 * fQ[1] * fQ[2] - 2 * fQ[0] * fQ[3], 2 * fQ[0]*fQ[0] + 2 * fQ[1] * fQ[1] - 1));
  fYpr[1] = degrees(atan(fGx / sqrt(fGy*fGy + fGz*fGz)));
  fYpr[2] = degrees(atan(fGy / sqrt(fGx*fGx + fGz*fGz)));
}
