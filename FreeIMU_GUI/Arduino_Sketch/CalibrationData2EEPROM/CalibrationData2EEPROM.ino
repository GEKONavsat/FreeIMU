
/**************************************************************************************************
 * Kyneo sketch: Calibration storage to EEPROM
 * 
 * Created on 9 Dic 2016 by GEKO Navsat S.L.
 * 
 * This example is free software, given under a GPL3 license.
 * 
 * KYNEO is an Arduino-compliant board which includes Movement & Location Sensors and a GNSS device. 
 * All these sensors' data can be logged into an micro-SD or, if a XBee compatible RF module is 
 * attached, they can be wirelessly shared among other devices within the network.
 * 
 * KYNEO is a product designed by GEKO Navsat S.L. 
 * http://www.gekonavsat.com
 * 
 * This sketch makes use of the standard Arduino's EEPROM library (included with the Arduino IDE software).
 * 
 * This code example takes the calibration information stored in the calibration.h file and saves it to
 * EEPROM. The calibration.h file has to be already generated (with the Kyneo calibration software of
 * with any other compatible with FreeIMU.)
 * 
 * IMPORTANT: Note that any previous calibration data stored on the EEPROM will be deleted when this 
 * sketch is executed. Whe strongly recomend you to save that data before it's overwritten.
 * 
 ******************************************************************************************************/

#include <calibration.h>
#include <EEPROM.h>

// Calibration standard EEPROM parameters
#ifndef FREEIMU_EEPROM_BASE
  #define FREEIMU_EEPROM_BASE 0x0A
#endif

#ifndef FREEIMU_EEPROM_SIGNATURE
  #define FREEIMU_EEPROM_SIGNATURE 0x19
#endif

// Variables definition
uint8_t dir = FREEIMU_EEPROM_BASE;
int error = 0;
char cmd = 'A';

// In case there is no calibration file...
#ifndef CALIBRATION_H
  error = 1;
#endif
    
void setup() {
  Serial.begin(9600);
  
  if(error == 1){                                                               // NO calibration.h file
    Serial.println("************************ ERROR ************************");
    Serial.println("There is no calibration file (calibration.h).");
    Serial.println("No new calibration information can be stored to EEPROM.");
    Serial.println("-> Try to create a calibration file and try again...");
    Serial.println("*******************************************************");
  }else{                                                                        // YES, there is a calibration.h file
    Serial.println("Calibration file detected...");
    delay(100);

    if(EEPROM.read(FREEIMU_EEPROM_BASE) == FREEIMU_EEPROM_SIGNATURE){
      Serial.println();
      Serial.println("There are already calibration parameters stored on the EEPROM: ");
      eeprom_printCal(FREEIMU_EEPROM_BASE);
      Serial.println();
      Serial.println("Are you sure you want to overwrite them? (y/n)");
    }else{
      Serial.println();
      Serial.println("There are no calibration parameters stored on the EEPROM.");
      Serial.println();
      Serial.println("Confirm you want to store the calibration parameters to EEPROM (y/n)");
    }

    while(1){
      if(Serial.available()){
        cmd = Serial.read();
          break;
      }
    }
    
    if(cmd == 'y' || cmd == 'Y'){
      Serial.println("The calibration data will be now saved to EEPROM....");
      delay(100);
      file2eeprom(dir);
      Serial.println("                                                    ...done!!");
      if(EEPROM.read(FREEIMU_EEPROM_BASE) == FREEIMU_EEPROM_SIGNATURE){
        eeprom_printCal(FREEIMU_EEPROM_BASE);
      }
    }else{
      Serial.println("No calibration data will be overwritten. Have a nice day :D");
    }
  }
}

void loop() {   // Main loop not in use in this sketch
}

// ------------------------------------------------------------
// --------------------- Required functions -------------------
// ------------------------------------------------------------

// EEPROM_READ: reads a single variable from the EEPROM
// Params.:     size -> size (bytes) of the variable to read
//              var -> address pointer of the variable
//              dir -> position address on EEPROM where the reading may start
// Ourput:      newdir -> EEPROM address that follows to the last on read
uint8_t eeprom_read(uint8_t size, byte * var, uint8_t dir) {
  for(uint8_t i = 0; i<size; i++) {
    var[i] = EEPROM.read(dir + i);
  }
  
  uint8_t newdir = dir + size;
  return newdir;
}

// EEPROM_PRINT: prints the value of a variable stored in the EEPROM
// Params.:     datatype -> type of data ('i' for integer, any other for float) (to be improved...)
//              dir -> position address on EEPROM where the reading may start
//              newline -> if different from zero, a carriage return will be done after printing
// Ourput:      newdir -> EEPROM address that follows to the last on read
uint8_t eeprom_print(char datatype, uint8_t dir, int newline){
  int int_ = 0;
  float float_ = 0;
  uint8_t newdir = 0;

  if(datatype == 'i'){
    newdir = eeprom_read(sizeof(int_), (byte *) &int_, dir);
    if(newline) Serial.println(int_);
    else        Serial.print(int_);
  }else{
    newdir = eeprom_read(sizeof(float_), (byte *) &float_, dir);
    if(newline) Serial.println(float_,6);
    else        Serial.print(float_,6);
  }
  
  return newdir;
}

// EEPROM_PRINTCAL: prints the calibration parameters' values stored on the EEPROM
// Params.:         dir -> FREEIMU_EEPROM_SIGNATURE address on EEPROM
void eeprom_printCal(uint8_t dir){
    dir++;
    
    Serial.print("acc_off_x: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("acc_off_y: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("acc_off_z: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("acc_scale_x: ");
    dir = eeprom_print('f', dir, 1);
    
    Serial.print("acc_scale_y: ");
    dir = eeprom_print('f', dir, 1);

    Serial.print("acc_scale_z: ");
    dir = eeprom_print('f', dir, 1);

    Serial.print("magn_off_x: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("magn_off_y: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("magn_off_z: ");
    dir = eeprom_print('i', dir, 1);

    Serial.print("magn_scale_x: ");
    dir = eeprom_print('f', dir, 1);
    
    Serial.print("magn_scale_y: ");
    dir = eeprom_print('f', dir, 1);

    Serial.print("magn_scale_z: ");
    dir = eeprom_print('f', dir, 1);
}

// FILE2EEPROM: saves all calibration parameters from calibration.h file to EEPROM
// Params.:         dir -> EEPROM address where FREEIMU_EEPROM_SIGNATURE should be written
void file2eeprom(uint8_t dir){
      EEPROM.write(dir, FREEIMU_EEPROM_SIGNATURE); dir++;
      EEPROM.put(dir, acc_off_x); dir = dir + sizeof(acc_off_x);
      EEPROM.put(dir, acc_off_y); dir = dir + sizeof(acc_off_y);
      EEPROM.put(dir, acc_off_z); dir = dir + sizeof(acc_off_z);
      EEPROM.put(dir, acc_scale_x); dir = dir + sizeof(acc_scale_x);
      EEPROM.put(dir, acc_scale_y); dir = dir + sizeof(acc_scale_y);
      EEPROM.put(dir, acc_scale_z); dir = dir + sizeof(acc_scale_z);
      EEPROM.put(dir, magn_off_x); dir = dir + sizeof(magn_off_x);
      EEPROM.put(dir, magn_off_y); dir = dir + sizeof(magn_off_y);
      EEPROM.put(dir, magn_off_z); dir = dir + sizeof(magn_off_z);
      EEPROM.put(dir, magn_scale_x); dir = dir + sizeof(magn_scale_x);
      EEPROM.put(dir, magn_scale_y); dir = dir + sizeof(magn_scale_y);
      EEPROM.put(dir, magn_scale_z); dir = dir + sizeof(magn_scale_z);
}
