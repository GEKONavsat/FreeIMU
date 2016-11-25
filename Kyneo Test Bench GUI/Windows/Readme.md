# IMU Sensors Performance Test Bench

The folders included side by side with this file are:

# Kyneo_GUI

Processing sketch to be launched on Processing 2 (newer versions can crash). It connects to the lower COM port detected and expects to receive NMEA and quaternion  frames from it.
NMEA are preceded by "$G" and quaternion frames are preceded by "$Q"

Processing can be downloaded from: https://processing.org/download/?processing

# FreeIMU_quaternion_Q

Contains the Arduino Sketch to be loaded into the Kyneo unit. It's basically the FreeIMU_quaternion example, modified so that the quaternion frames sent by Kyneo are preceded by "$Q", and NMEA frames are preceded by "$G".

(c) GEKO NAVSAT 2016