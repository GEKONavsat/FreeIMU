# Kyneo IMU sensors calibration and performance testing.

The folders included side by side with this file are:

# FreeIMU_GUI

Calibrate the Kyneo MARG sensors operation.

Includes:

	- Arduino_Sketch\FreeIMU_serial: Arduino sketch to be uploaded to Kyneo.
	- FreeIMU_GUI\cal_gui.py: User interface, based on python.
	
# Kyneo Test Bench GUI

Test the Kyneo performance, specially once it's been calibrated. Includes Windows and Linux folders.

The Windows folder includes:

	- FreeIMU_quaternion_Q: Arduino sketch to be uploaded to Kyneo.
	- Kyneo_GUI: User interface, based on proccesing.

Note that you don't need to add the libraries folder is you already have FreeIMU package inside your user's 
Arduino folder.

(c) GEKO NAVSAT 2016