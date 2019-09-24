# GUIProject
A graphic user interface to help users of a wearable surface stimulator select amplitude and timing of signals

Before attempting to open the GUI files, download the free Processing Sketchbook by going to processing.org.  After downloading Processing
Sketchbook, download the GUIProject-master zip files.  Open the folder and double click on the open source code file titled 
GUIProject.  You will be asked to create a sketch titled GUIProject.  Accept this, and the program will be opened.  To run the GUI, click
the triangle-shaped run button in the upper left corner of the sketch.  If your computer is not connected via a UART connection line to 
the stimulator prior to running, the program will not work.  Once you can see the interface, to specify a setting, you must type the 
desired value into the text box, then press the enter key before clicking outside of the text box.  If you have successfully entered a 
setting, you will get a confirmation message in the black box underneath the code on the Processing Sketch.  Once you have successfully 
entered all desired settings, you must click both the 'SetTiming' and 'SetAmplitude' buttons.  If you have succesfully sent your settings
to the stimulator, you will get a confirmation message in the black box underneath the code on the Processing Sketch.  Once you have 
sent your settings, you can press the 'StartStim' button to begin stimulation.  The 'CheckBatteryStatus' button will return the number of 
volts left in your battery in the black box in the Processing Sketch.  The 'GetHistory' button will return 200 bits of stored information 
from the stimulator and report them in the black box.  To see a full history, clcik the 'sketch' tab on the top of the Processing Sketch, 
and click 'Show Sketch Folder'.  From this, click the 'data' folder at the top of the file list to see an excel spreadsheet of collected 
data.  For more advanced settings, click the 'OpenAdvancedSettings' button at the bottom of the interface.  From the advanced settings 
page, the user can specify between stimulation pulsewidth or interpulse delay or recharge pulsewidth, stimulation amplitude or recharge 
amplitude, and channel 1 or channel 2.  From this page, simple checks to ensure the stimulator communications are working can also be
utilized.  The user can ensure communications with the stimulator by checking the buzzer, or by turning on the LEDs.
