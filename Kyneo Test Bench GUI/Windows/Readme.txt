(c) GEKO NAVSAT 2016

The folders included side by side with this file are:

Kyneo_GUI: Processing sketch to be launched on Processing 2 (newer versions can crash). It connects to the lower COM port
detected (i.e. it wil choose the port which name has the lower number after "COM") and expects to receive NMEA and quaternion 
frames from it. NMEA are preceded by "$G" and quaternion ones are preceded by "$Q"

FreeIMU_quaternion_Q: contains the Arduino Sketch to be loaded into the Kyneo unit. It's basically the FreeIMU_quaternion example,
modified so that the quaternion frames sent by Kyneo are preceded by "$Q", and NMEA frames will be sent as well, in this case 
preceded by "$G".