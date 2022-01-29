## Table of contents
* [Project](#Project)

•	[Purpose](#purpose)

•	[Features](#features)

•	[Accelerometer Data into Displacements](#accelerometer-data-into-displacements)

## Project
Please download the entire folder and load project on flutter from Google. Code is under [lib](https://github.com/Nhesneil/cpr_app_project/blob/master/lib/main.dart)

## Purpose

The mobile app will not only guide the user on how to do CPR (Cardiopulmonary resuscitation) but will also give the user feedbacks on the depth of his/her compressions. While CPR is being performed, the app will alert authorities of the emergency by sending them a signal of their location.

## Features
1.	Depth of compressions feedback (Currently working on)
*	The accelerometer data will be processed to provide accurate feedback to the user
*	The feedback will be through a pre-recorded speech played by the phone saying, "Compress more!"
*	This is an important feature since performing each compressions have a minimum depth to be effective
2.	Rate of compression guide (Yet to be implemented)
*	The beats per minute(bpm) will be presented through a metronome at a fixed rate
3. 	Signal to be sent to authorities (Yet to be implemented)
*	As soon the application gets opened, data such as the location of the user will be sent to the authorities
*	
## Accelerometer Data into Displacements
To give the user feedback of each depth of compressions, the accelerometer needs to be accessed from the phone. The data will then be stored and transformed into displacements using the spectral method.
Please see [processed data folder](https://github.com/Nhesneil/cpr_app_project/tree/master/process_data) for more information.
