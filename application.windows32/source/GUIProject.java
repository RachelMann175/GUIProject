import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.serial.*; 
import java.util.List; 
import java.util.Arrays; 
import java.io.File; 
import javax.xml.bind.DatatypeConverter; 
import java.util.Scanner; 
import java.io.FileNotFoundException; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GUIProject extends PApplet {



//BatteryLogging batteryThread;
ControlP5 cp5;
AdvancedSettings as;
List<String> simpleSettingEvents;
List<String> simpleButtons;

Serial thePort;
Textlabel textLabel;
TimingCommand tc = new TimingCommand();
AmplitudeSettings amplitudes = new AmplitudeSettings();

public void settings() {
  size(700,1600);
}

public void draw() {
  background(0);
}
  
public void setup(){
  
  PFont font = createFont("Arial", 20);
  int baudRate = 115200;
  String portName = Serial.list()[0];
  thePort = new Serial(this, portName, baudRate);
  
  //batteryThread = new BatteryLogging();
  //batteryThread.run();
  cp5 = new ControlP5(this);
  background(0);
  as = new AdvancedSettings();
  
  simpleSettingEvents= Arrays.asList("Amplitude: mA", "Frequency: Hz",
                                   "Pulsewidth: us", "Duration: min");
  
  cp5.addTextfield("Amplitude: mA")
  .setPosition(20,50)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false)
  .getCaptionLabel().setFont(font);
  
  cp5.addTextlabel("Current Amplitude")
  .setPosition(260,50)
  .setSize(200,40)
  .setStringValue("")
  .setFont(font);
  
  Label B1 = cp5.addBang("Amplitude Up")
  .setPosition(400,30)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B1.setFont(font);
  
  Label B2 = cp5.addBang("Amplitude Down")
  .setPosition(580,30)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B2.setFont(font);
  
  cp5.addTextfield("Frequency: Hz")
  .setPosition(20,150)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false)
  .getCaptionLabel().setFont(font);
  
  cp5.addTextfield("Pulsewidth: us")
  .setPosition(20,250)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false)
  .getCaptionLabel().setFont(font);
  
  cp5.addTextfield("Duration: min")
  .setPosition(20,350)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false)
  .getCaptionLabel().setFont(font);
  
  simpleButtons = Arrays.asList("StartStim", "StopStim", 
                                 "SetAmplitude", "SetTiming",
                                 "Amplitude Up", "Amplitude Down",
                                 "GetBatteryStatus");
  
  Label B3 = cp5.addBang("StartStim")
  .setPosition(20,550)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B3.setFont(font);
  
  Label B4 = cp5.addBang("StopStim")
  .setPosition(260,550)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B4.setFont(font);
  
  Label B5 = cp5.addBang("SetAmplitude")
  .setPosition(20,450)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B5.setFont(font);
  
  Label B6 = cp5.addBang("SetTiming")
  .setPosition(260,450)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B6.setFont(font);
  
  Label B7 = cp5.addBang("OpenAdvancedSettings")
  .setPosition(20,750)
  .setSize(400,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B7.setFont(font);
  
  Label B8 = cp5.addBang("Get History")
  .setPosition(20,650)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B8.setFont(font);
  
  Label B9 = cp5.addBang("Clear History")
  .setPosition(250,650)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B9.setFont(font);
  
  Label B10 = cp5.addBang("BatteryStatus")
  .setPosition(480,650)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  B10.setFont(font);
  
}


public void controlEvent(ControlEvent theEvent) throws InterruptedException {
  
  if(theEvent.getName() == "OpenAdvancedSettings"){
    String[] args = {"Opening advanced settings"};
    thePort.stop();
    AdvancedSettings window = new AdvancedSettings();
    PApplet.runSketch(args, window);
  }
  
  if(simpleSettingEvents.contains(theEvent.getName())){
    
    int intensity = Integer.parseInt(theEvent.getStringValue());
    switch(theEvent.getName()){
    
      case "Amplitude: mA" :
      amplitudes.setStimSetting(1, true, intensity);
      amplitudes.setRchrgSetting(1, false, intensity);
      amplitudes.setStimSetting(2, false, intensity);
      amplitudes.setRchrgSetting(2, false, intensity);
      textLabel.setText(str(intensity));
      break;
      
      case "Frequency: Hz" :
      double freq = 1000 * (1 / ((double)intensity));
      tc.setPulsePeriod(freq);
      break;
      
      case "Pulsewidth: us" :
      tc.setStimPulseWidth(intensity);
      tc.setInterpulseDelay(intensity);
      tc.setRechargePulseWidth(intensity);
      break;
      
      case "Duration: min" :
      tc.setDuration(intensity);
      break;
      
    }
  }
  if(simpleButtons.contains(theEvent.getName())){
    
    int stimIntensity1 = amplitudes.getChannelSettings()[0].getStimSetting().getIntensity();
    int rchrgIntensity1 = amplitudes.getChannelSettings()[0].getRchrgSetting().getIntensity();
    int stimIntensity2 = amplitudes.getChannelSettings()[1].getStimSetting().getIntensity();
    int rchrgIntensity2 = amplitudes.getChannelSettings()[1].getRchrgSetting().getIntensity();
    
    switch(theEvent.getName()){
      
      case "SetAmplitude" :
      as.setAmplitude();
      break;
      
      case "SetTiming" :
      as.setTiming();
      break;
      
      case "StartStim" :
      as.startStim();
      break;
      
      case "StopStim" :
      as.stopStim();
      break;
      
      case "GetBatteryStatus" :
      as.CheckBattery();
      break;

      case "Amplitude Up" :
      println("amplitude up");
      stimIntensity1++;
      rchrgIntensity1++;
      stimIntensity2++;
      rchrgIntensity2++;
      amplitudes.setStimSetting(1, stimSet1, stimIntensity1);
      amplitudes.setRchrgSetting(1, rchrgSet1, rchrgIntensity1);
      amplitudes.setStimSetting(2, stimSet2, stimIntensity2);
      amplitudes.setRchrgSetting(2, rchrgSet2, rchrgIntensity2);
      textLabel.setText(str(stimIntensity1));
      break;
      
      case "Amplitude Down" :
      println("amplitude down");
      stimIntensity1--;
      rchrgIntensity1--;
      stimIntensity2--;
      rchrgIntensity2--;
      amplitudes.setStimSetting(1, stimSet1, stimIntensity1);
      amplitudes.setRchrgSetting(1, rchrgSet1, rchrgIntensity1);
      amplitudes.setStimSetting(2, stimSet2, stimIntensity2);
      amplitudes.setRchrgSetting(2, rchrgSet2, rchrgIntensity2);
      textLabel.setText(str(stimIntensity1));
      break;
    } 
  }
}
     








//Lists used to group the different types of events that can occur
List<String> amplitudeInputs;
List<String> timingInputs;
List<String> buttons;
List<String> checkBoxes;

//Variables to store if the stimulus is a source or a sink
private boolean stimSet1;
private boolean stimSet2;
private boolean rchrgSet1;
private boolean rchrgSet2;

//A table in which FRAM data will be stored
Table table = new Table();

//Variables used to specifically name files stored as tables with information extracted from FRAM
String filename;
byte[] byteFiles;
byte[] batteryReturn;

class AdvancedSettings extends PApplet{

public void settings(){
  size(700,1600);
}

public void setup() {
  
  PFont font = createFont("Arial", 20);
  
  cp5 = new ControlP5(this);
  
  //Adding Data, Time, Date columns to the table
  table.addColumn("Data");
  table.addColumn("Time");
  table.addColumn("Date");
  
  //Adding the timing setting event names to the timingInputs list
  timingInputs = Arrays.asList("Stim PW (us)", "Interpulse Delay (us)",
                                 "Recharge PW (us)", "Pulse Period (ms)",
                                 "Duration (min)");
  
  cp5.addTextfield("Stim PW (us)")
  .setPosition(20,50)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addTextfield("Interpulse Delay (us)")
  .setPosition(20,120)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
    
  cp5.addTextfield("Recharge PW (us)")
  .setPosition(20,190)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
    
  cp5.addTextfield("Pulse Period (ms)")
  .setPosition(20,260)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addTextfield("Duration (min)")
  .setPosition(250,50)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  //Adding the amplitude setting event names to the amplitudeInputs list
  amplitudeInputs = Arrays.asList("Channel 1 Stim: mA", "Channel 1 Rchrg: mA",
                                   "Channel 2 Stim: mA", "Channel 2 Rchrg: mA");
                                   
  cp5.addTextfield("Channel 1 Stim: mA")
  .setPosition(20,330)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addBang("Stim1Up")
  .setPosition(240,310)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Stim1Down")
  .setPosition(420,310)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addTextfield("Channel 1 Rchrg: mA")
  .setPosition(20,470)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addBang("Rchrg1Up")
  .setPosition(240,450)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Rchrg1Down")
  .setPosition(420,450)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);  
  
  cp5.addTextfield("Channel 2 Stim: mA")
  .setPosition(20,610)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addBang("Stim2Up")
  .setPosition(240,590)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Stim2Down")
  .setPosition(420,590)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addTextfield("Channel 2 Rchrg: mA")
  .setPosition(20,750)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addBang("Rchrg2Up")
  .setPosition(240,730)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Rchrg2Down")
  .setPosition(420,730)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  //Adding the checkbox event names to the checkBoxes list
  checkBoxes = Arrays.asList("Channel 1 Stim: sink", "Channel 1 Stim: source",
                             "Channel 1 Rchrg: sink", "Channel 1 Rchrg: source",
                             "Channel 2 Stim: sink", "Channel 2 Stim: source", 
                             "Channel 2 Rchrg: sink", "Channel 2 Rchrg: source");
                             
  cp5.addCheckBox("Channel 1 Stim: sink")
  .setPosition(20,400)
  .setSize(30,40)
  .addItem("Channel 1 stim sink", 0);
  
  cp5.addCheckBox("Channel 1 Stim: source")
  .setPosition(150,400)
  .setSize(30,40)
  .addItem("Channel 1 stim source", 1);
  
  cp5.addCheckBox("Channel 1 Rchrg: sink")
  .setPosition(20,540)
  .setSize(30,40)
  .addItem("Channel 1 rchrg sink", 2);
  
  cp5.addCheckBox("Channel 1 Rchrg: source")
  .setPosition(150,540)
  .setSize(30,40)
  .addItem("Channel 1 rchrg source", 3);
  
  cp5.addCheckBox("Channel 2 Stim: sink")
  .setPosition(20,680)
  .setSize(30,40)
  .addItem("Channel 2 stim sink", 4);
  
  cp5.addCheckBox("Channel 2 Stim: source")
  .setPosition(150,680)
  .setSize(30,40)
  .addItem("Channel 2 stim source", 5);
  
  cp5.addCheckBox("Channel 2 Rchrg: sink")
  .setPosition(20,820)
  .setSize(30,40)
  .addItem("Channel 2 rchrg sink", 6);
  
  cp5.addCheckBox("Channel 2 Rchrg: source")
  .setPosition(150,820)
  .setSize(30,40)
  .addItem("Channel 2 rchrg source", 7);
  
  //Adding the bang event names to the buttons list
  buttons = Arrays.asList("Stim1Up", "Stim1Down", "Rchrg1Up", "Rchrg1Down", 
                          "Stim2Up", "Stim2Down", "Rchrg2Up", "Rchrg2Down");
                                                  
                          
  cp5.addBang("ClearPulseTimings")
  .setPosition(420,890)
  .setSize(80, 40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("ClearAmplitudes")
  .setPosition(520,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("startStim")
  .setPosition(20,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("stopStim")
  .setPosition(120,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("setTiming")
  .setPosition(220,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("setAmplitude")
  .setPosition(320,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Buzzer")
  .setPosition(480,50)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("StopBuzzer")
  .setPosition(600,50)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("GetHistory")
  .setPosition(480,120)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("ClearHistory")
  .setPosition(600,120)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("TurnOnLEDs")
  .setPosition(480,190)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("CheckBattery")
  .setPosition(600,190)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  textFont(font);
  
  //Serial variables and baud rate settings
  int baudRate = 115200;
  String portName = Serial.list()[0];
  thePort = new Serial(this, portName, baudRate);
  
  background(0);
  fill(255);
}

public void draw(){
}

//A button to start the buzzer, used for preliminary testing of the WSS board
public void Buzzer(){
  
  // a byte array to store the hexidecimals that will cause a buzz
  byte[] buzz;
  buzz = new byte[] { (byte) 0x00, (byte) 0x80, (byte) 0x05, (byte) 0x01, 
                      (byte) 0x01, (byte) 0x00, (byte) 0xC0};
  println("Buzzing");
  
  //writing the byte array to the serial port
  thePort.write(buzz);
}

//A button to stop the buzzer once it has been started
public void StopBuzzer(){
  
  // a byte array to store the hexadecimals that will stop the buzz
  byte[] stopBuzz = { (byte) 0x00, (byte) 0x80, (byte) 0x05, (byte) 0x01, 
                      (byte) 0x00, (byte) 0x00, (byte) 0xC0};
                      
  //writing the byte array to the serial port
  thePort.write(stopBuzz);
  
  println("Stopping buzzer");
}

//A button to turn on the LED lights
public void TurnOnLEDs(){
  
  //a byte array to store the hexadecimals that will turn on the LEDs
  byte[] LEDByte = {0x00, (byte) 0x80, (byte) 0x08, 0x02, 0x01, (byte) 0x0F, 
                    0x00, (byte) 0xC0};
  
  //writing the byte array to the serial port
  thePort.write(LEDByte);
  
  //tell the user
  println();
  println("Turning on LEDs");
}

//A button that will start stimulation once the timing and amplitude have been set, take note of the time and date, and prompt the FRAM to return stored data to a table
public void startStim() throws InterruptedException {
  
  //variables to store the date and time of stimulation
  int day = day();
  int month = month();
  int year = year();
  int hour = hour();
  int min = minute();
  int s = second();
 
  // a byte array to store the hexidecimals that will start the stimulation
  byte[] startingStim;
  startingStim = new byte[] { 0x00, (byte) 0x80, 0x0B, 0x01, 
                  0x03, 0x00, (byte) 0xC0 };
  
  // a byte array to read 200 bytes from the FRAM                
  byte[] readData;
  readData = new byte[] { 0x00, (byte) 0x80, 0x09, 0x01, 
                      0x05, 0x00, (byte) 0xC0 };
  
  println();
  println("Starting Stim");
  
  //writing the byte array to the serial port
  thePort.write(startingStim);
  
  //setting a file to be stored in the data folder, and naming it with the date and time of stimulation
  filename = "C:\\Users\\Setup\\Documents\\GitHub\\GUIProject\\data\\" + str(month) + "-" + str(day) + "--" + str(hour) 
             + "-" + str(min) + "-" + str(s) + ".csv";
  
  //wait for .5 seconds
  Thread.sleep(500);
  
  //if the port is available
  while(thePort.available() > 0) {
    
    //read data from the board
    thePort.write(readData);
    
    //and store that data as a String
    byteFiles = thePort.readBytes();
    thePort.readBytes(byteFiles);
    
    //if the data collected from the FRAM is not null
    if(byteFiles != null){
      
      //add the data to the Data column of the table
      String storedFiles = DatatypeConverter.printHexBinary(byteFiles);
      storedFiles = storedFiles.replaceAll("..", "$0 ");
      println();
      println(storedFiles);
      TableRow row = table.addRow();
      row.setString("Data", storedFiles);
      row.setString("Time", str(hour) + ":" + str(min) + ":" + str(s));
      row.setString("Date", str(month) + "/" + str(day) + "/" + str(year));
      saveTable(table, filename);
    }
    
    //if there is no data collected from the FRAM
    else{
      
      //show in the table that no data was received
      TableRow row = table.addRow();
      println("Null data received");
      row.setString("Data", "Null data received");
      row.setString("Time", str(hour) + ":" + str(min) + ":" + str(s));
      row.setString("Date", str(month) + "/" + str(day) + "/" + str(year));
      saveTable(table, filename);
      
    }
  }
  
  //if there are no bytes available
  if(thePort.available() == 0){
    
    //show in the table that no data was received
    TableRow row = table.addRow();
    println("There are no bytes available");
    row.setString("Data", "No bytes available");
    row.setString("Time", str(hour) + ":" + str(min) + ":" + str(s));
    row.setString("Date", str(month) + "/" + str(day) + "/" + str(year));
    saveTable(table, filename);
   
  }
  
  Thread.sleep((long) (60000 * tc.getDuration()));
  
  as.stopStim();
}

public void stopStim(){
  
  //a byte to stop stimulation
  byte[] stopBytes;
  stopBytes = new byte[] {/*insert stop byte here*/};
  
  //send the byte to the board
  thePort.write(stopBytes);
  
  //tell the user
  println("Stopping stimulation");
}

//A button to send the byte with timing settings to the WSS, rest of timing byte built in TimingCommand class
public void setTiming(){
  println();
  println("Timing array");
  tc.getTimingOutput()[0] = (byte) 0x00;
  tc.getTimingOutput()[1] = (byte) 0x80;
  tc.getTimingOutput()[2] = (byte) 0x0B;
  tc.getTimingOutput()[3] = (byte) 0x05;
  tc.getTimingOutput()[4] = (byte) 0x02;
  tc.getTimingOutput()[9] = (byte) 0x00;
  tc.getTimingOutput()[10] = (byte) 0xC0;
  thePort.write(tc.getTimingOutput());
  tc.printTimingOutput();
}

//A button to sent the byte with amplitude settings to the WSS, amplitude byte built in AmplitudeSettings class
public void setAmplitude(){
  amplitudes.sendSettingsToBoard(thePort);
} 

//A button to print the table that stores FRAM data
public void GetHistory() throws FileNotFoundException{
  
  //read the file with the table in it
  Scanner scanner = new Scanner(new File(filename));
  
  //put a space after each comma
  scanner.useDelimiter(",");
  while(scanner.hasNext()){
    System.out.print(scanner.next() + " ");
  }
  scanner.close();
}

//A button to delete the files that store the FRAM data tables
public void ClearHistory(){
  File f = new File(filename);
  if(f.exists()){
    f.delete();
    println("History cleared");
  }
  else{
    println("No such files");
  }
}

//A button to clear the timing setting textfields
public void ClearPulseTimings() {
  cp5.get(Textfield.class,"Stim PW (us)").clear();
  cp5.get(Textfield.class,"Interpulse Delay (us)").clear();
  cp5.get(Textfield.class,"Recharge PW (us)").clear();
  cp5.get(Textfield.class,"Pulse Period (ms)").clear();
}

//A button to check the status of the battery
public void CheckBattery(){
  
  //A byte to command the board to send the data
  byte[] batteryByte;
  batteryByte = new byte[] {0x00, (byte) 0x80, 0x02, 0x01, 0x01, 0x00, (byte) 0xC0};
  
  //write the battery byte to the port
  thePort.write(batteryByte);
  
  //collect the return byte array from the board
  batteryReturn = thePort.readBytes();
  thePort.readBytes(batteryReturn);
  
  //convert the byte array to a string
  if(batteryReturn != null){
    String storedFiles = DatatypeConverter.printHexBinary(batteryReturn);
    String importantDigits = storedFiles.substring(12,16);
    int importantNum = Integer.parseInt(importantDigits,16);
    float finalNum = importantNum / 4095 * 2.5f * 2;
    println();
    println("Battery status is: ");
    println(finalNum + " volts");
  }
}

//A button to clear the amplitude setting textfields
public void ClearAmplitudes() {
  cp5.get(Textfield.class,"Channel 1 Stim: Sink mA").clear();
  cp5.get(Textfield.class,"Channel 2 Stim: Source mA").clear();
  cp5.get(Textfield.class,"Channel 1 Rchrg: Source mA").clear();
  cp5.get(Textfield.class,"Channel 2 Rchrg: Sink mA").clear();
}


//A method to access the other classes in order to set amplitude and timing when the 'enter' button is pressed in each textfield
public void controlEvent(ControlEvent theEvent){

  //if the user is trying to enter amplitude and timing settings
  if(amplitudeInputs.contains(theEvent.getName()) || timingInputs.contains(theEvent.getName())){
    try {  
      
      //store the number they have entered
      int intensity = Integer.parseInt(theEvent.getStringValue());
      
      switch(theEvent.getName()){
        
        //if the user is setting amplitude of channel 1 stim
        case "Channel 1 Stim: mA":
          
          //use the AmplitudeSettings class to set channel 1 amplitude to the entered number
          amplitudes.setStimSetting(1, stimSet1, intensity);
          break;
        
        //if the user is setting amplitude of channel 2 stim
        case "Channel 2 Stim: mA":
          
          //use the AmplitudeSettings class to set channel 2 amplitude to the entered number
          amplitudes.setStimSetting(2, stimSet2, intensity);
          break;
        
        //if the user is setting amplitude of channel 1 recharge
        case "Channel 1 Rchrg: mA":
        
          //use the AmplitudeSettings class to set channel 1 recharge to the entered number
          amplitudes.setRchrgSetting(1, rchrgSet1, intensity);
          break;
        
        //if the user is setting amplitude of channel 2 recharge
        case "Channel 2 Rchrg: mA":
        
          //use the AmplitudeSettings class to set channel 2 recharge to the entered number
          amplitudes.setRchrgSetting(2, rchrgSet2, intensity);
          break;
  
        // if user is setting stimulus pulse width
        case "Stim PW (us)":
        
          //use the TimingCommand class to set stimulus pulse width to the entered number
          tc.setStimPulseWidth(intensity);
          break;
  
        // if user is setting interpulse delay
        case "Interpulse Delay (us)":
          
          //use the TimingCommand class to set the interpulse delay to the entered number
          tc.setInterpulseDelay(intensity);
          break;
  
        // if user is setting recharge pulse width
        case "Recharge PW (us)":
        
          //use the TimingCommand class to set the recharge pulse width to the entered number
          tc.setRechargePulseWidth(intensity);
          break;
  
        // if user is setting pulse period
        case "Pulse Period (ms)":
        
          //use the TimingCommand class to set the pulse period to the entered number
          tc.setPulsePeriod(intensity);
          break;
          
        // if user is setting duration
        case "Duration (min)":
        
          //use the TimingCommand class to set the duration to the entered number
          tc.setDuration(intensity);
          break;
          
      }
    }
      catch (NumberFormatException e) {
      println("Error: Must enter valid integer input!");
    }
  }
  
  //if the user is trying to determine sink/source settings using the checkboxes
  if(checkBoxes.contains(theEvent.getName())){
    switch(theEvent.getName()){
      
      //if the user wants channel 1 stim to be a sink
      case "Channel 1 Stim: sink":
        
        //change the sink setting for channel 1 stim to be true
        stimSet1 = true;
        break;
      
      //if the user wants channel 1 stim to be a source 
      case "Channel 1 Stim: source":
      
        //change the sink setting for channel 1 stim to be false
        stimSet1 = false;
        break;
      
      //if the user wants channel 2 stim to be a sink
      case "Channel 2 Stim: sink":
      
        //change the sink setting for channel 2 stim to be true
        stimSet2 = true;
        break;
       
      //if the user wants channel 2 stim to be a source
      case "Channel 2 Stim: source":
      
        //change the sink setting for channel 2 stim to be false
        stimSet2 = false;
        break;
      
      //if the user wants channel 1 recharge to be a sink
      case "Channel 1 Rchrg: sink":
      
        //change the sink setting for channel 1 recharge to be true
        rchrgSet1 = true;
        break;
      
      //if the user wants channel 1 recharge to be a source
      case "Channel 1 Rchrg: source":
      
        //change the sink setting for channel 1 recharge to be false
        rchrgSet1 = false;
        break;
      
      //if the user wants channel 2 recharge to be a sink
      case "Channel 2 Rchrg: sink":
      
        //change the sink setting for channel 2 recharge to be true
        rchrgSet2 = true;
        break;
      
      //if the user wants channel 2 recharge to be a source
      case "Channel 2 Rchrg: source":
      
        //change the sink setting for channel 2 recharge to be false
        rchrgSet2 = false;
        break;
    }
  }
  
  //if the user pushes one of the arrow buttons
  if(buttons.contains(theEvent.getName())){
    
    int stimIntensity1 = amplitudes.getChannelSettings()[0].getStimSetting().getIntensity();
    int rchrgIntensity1 = amplitudes.getChannelSettings()[0].getRchrgSetting().getIntensity();
    int stimIntensity2 = amplitudes.getChannelSettings()[1].getStimSetting().getIntensity();
    int rchrgIntensity2 = amplitudes.getChannelSettings()[1].getRchrgSetting().getIntensity();
    
    switch(theEvent.getName()){
      
      //if the user pushes stim1up
      case "Stim1Up":
      
        //change the intensity
        stimIntensity1++;
        amplitudes.setStimSetting(1, stimSet1, stimIntensity1);
        break;
        
      case "Stim1Down":
        stimIntensity1--;
        amplitudes.setStimSetting(1, stimSet1, stimIntensity1);
        break;
        
      case "Rchrg1Up":
        rchrgIntensity1++;
        amplitudes.setRchrgSetting(1, rchrgSet1, rchrgIntensity1);
        break;
        
      case "Rchrg1Down":
        rchrgIntensity1--;
        amplitudes.setRchrgSetting(1, rchrgSet1, rchrgIntensity1);
        break;
        
      case "Stim2Up":
        stimIntensity2++;
        amplitudes.setStimSetting(2, stimSet2, stimIntensity2);
        break;
        
      case "Stim2Down":
        stimIntensity2--;
        amplitudes.setStimSetting(2, stimSet2, stimIntensity2);
        break;
        
      case "Rchrg2Up":
        rchrgIntensity2++;
        amplitudes.setRchrgSetting(2, rchrgSet2, rchrgIntensity2);
        break;
        
      case "Rchrg2Down":
        rchrgIntensity2--;
        amplitudes.setRchrgSetting(2, rchrgSet2, rchrgIntensity2);
        break;
    }
  }
}
}
public class AmplitudeSettings {
  
  private static final int NUM_CHANNELS = 2;
  
  //byte arrays to store the numbers at the beginning and end of the hexadecimal that will set amplitude
  private final byte[] START_BYTES = {0x00, (byte) 0x80, 0x0B, 0x11, 0x01};
  private final byte[] END_BYTES = {0x00, 0x00, 0x00, 0x00, 0x00};
  private final byte[] INTERMEDIATE = {0x00, 0x00, 0x00, 0x00};
  
  //an array to store stim vs recharge settings
  private ChannelSetting[] channelSettings;
  
  //a constructor to instantiate an array of the four possible channels
  public AmplitudeSettings() {
    channelSettings = new ChannelSetting[NUM_CHANNELS];
    for (int i = 0; i < NUM_CHANNELS; i++) {
      channelSettings[i] = new ChannelSetting();
    }
  }
  
  public ChannelSetting[] getChannelSettings(){
    return channelSettings;
  }
  
  //a method to set the sink/source settings and intensity of the specified channel for the stim waveform
  public void setStimSetting(int channel, boolean sink, int intensity) {
    
    // sets stim setting and sends it to the board
    try {
      
      //set the sink/source and intensity of the specified channel 
      channelSettings[channel - 1].setStimSetting(sink, intensity);
      
      //store the current sink/source setting and amplitude intensity of the specified channel
      SubChannelSetting newSettings = channelSettings[channel - 1].getStimSetting();
      
      //inform the user of the current settings
      println("Successfully set channel " + channel + " stim to " + (newSettings.getSink() ? "sink " : "source ") + newSettings.getIntensity() + " mA");
      
    } catch (ArrayIndexOutOfBoundsException e) {
      println(e);
    }
  }
  
  public void setRchrgSetting(int channel, boolean sink, int intensity) {
    // sets rchrg setting and sends it to the board
    try {
      channelSettings[channel - 1].setRchrgSetting(sink, intensity);
      SubChannelSetting newSettings = channelSettings[channel - 1].getRchrgSetting();
      println("Successfully set channel " + channel + " rchrg to " + (newSettings.getSink() ? "sink " : "source ") + newSettings.getIntensity() + " mA");
    } catch (ArrayIndexOutOfBoundsException e) {
      println(e);
    }
  }
  
  public void sendSettingsToBoard(Serial port) {
    
    //Two byte arrays for stim settings and recharge settings
    byte[] STIM_SET_BYTES_1 = new byte[2];
    byte[] STIM_SET_BYTES_2 = new byte[2];
    byte[] RCHRG_SET_BYTES_1 = new byte[2];
    byte[] RCHRG_SET_BYTES_2 = new byte[2];
      
    //send the proper hexadecimal to the stim set byte array for channel 1
    STIM_SET_BYTES_1 = channelSettings[0].stimSettingToBytes();
      
    //and send the proper hexadecimal to the recharge set byte array for channel 1
    RCHRG_SET_BYTES_1 = channelSettings[0].rchrgSettingToBytes();
    
    //send the proper hexadecimal to the stim set byte array for channel 2
    STIM_SET_BYTES_2 = channelSettings[1].stimSettingToBytes();
    
    //send the proper hexadecimal to the recharage set byte array for channel 2
    RCHRG_SET_BYTES_2 = channelSettings[1].rchrgSettingToBytes();
    
    //copy the start byte array, setting byte arrays, and end byte array to one amplitudeArray to be sent to the port
    byte[] amplitudeArray = new byte[START_BYTES.length + STIM_SET_BYTES_1.length + RCHRG_SET_BYTES_1.length + STIM_SET_BYTES_2.length + RCHRG_SET_BYTES_2.length +INTERMEDIATE.length + END_BYTES.length];
    
    //copty the start byte array
    System.arraycopy(START_BYTES, 0, amplitudeArray, 0, START_BYTES.length);
    
    //copy the stim channel 1 byte array
    System.arraycopy(STIM_SET_BYTES_1, 0, amplitudeArray, START_BYTES.length, STIM_SET_BYTES_1.length);
    
    //copy the stim channel 2 byte array
    System.arraycopy(STIM_SET_BYTES_2, 0, amplitudeArray, START_BYTES.length 
                                                        + STIM_SET_BYTES_1.length, STIM_SET_BYTES_2.length);
                                                   
    //copy the intermediate byte array                                                    
    System.arraycopy(INTERMEDIATE, 0, amplitudeArray, START_BYTES.length 
                                                    + STIM_SET_BYTES_1.length 
                                                    + STIM_SET_BYTES_2.length, INTERMEDIATE.length);
    
    //copy the recharge channel 1 byte array
    System.arraycopy(RCHRG_SET_BYTES_1, 0, amplitudeArray, START_BYTES.length 
                                                         + STIM_SET_BYTES_1.length 
                                                         + STIM_SET_BYTES_2.length 
                                                         + INTERMEDIATE.length, RCHRG_SET_BYTES_1.length);
    
    //copy the recharge channel 2 byte array                                                     
    System.arraycopy(RCHRG_SET_BYTES_2, 0, amplitudeArray, START_BYTES.length 
                                                         + STIM_SET_BYTES_1.length 
                                                         + STIM_SET_BYTES_2.length 
                                                         + INTERMEDIATE.length 
                                                         + RCHRG_SET_BYTES_1.length, RCHRG_SET_BYTES_2.length);
    
    //copy the ending byte array                                                     
    System.arraycopy(END_BYTES, 0, amplitudeArray, START_BYTES.length 
                                                 + STIM_SET_BYTES_1.length 
                                                 + STIM_SET_BYTES_2.length 
                                                 + INTERMEDIATE.length 
                                                 + RCHRG_SET_BYTES_1.length 
                                                 + RCHRG_SET_BYTES_2.length, END_BYTES.length);
    
    //send the final array to the port
    port.write(amplitudeArray);
    
    
    println();
    println("Amplitude array");
    for(int i = 0; i < amplitudeArray.length; i++){
      print(amplitudeArray[i] + ", ");
    }
  }
}
/*public class BatteryLogging extends PApplet {
  
  Serial myPort;
  
  void setup(){
    myPort = new Serial(this, Serial.list()[1], 115200);
  }
  
  public void run() {
    int day = day();
    int month = month();
    int year = year();
    int hour = hour();
    int min = minute();
    int s = second();
    
    delay(200);
      
    //if the port is available
    while(myPort.available() > 0) {
      //A byte to command the board to send the data
      byte[] batteryByte;
      batteryByte = new byte[] {0x00, (byte) 0x80, 0x02, 0x01, 0x01, 0x00, (byte) 0xC0};
  
      //write the battery byte to the port
      myPort.write(batteryByte);
  
      //collect the return byte array from the board
      batteryReturn = myPort.readBytes();
      myPort.readBytes(batteryReturn);
  
      //convert the byte array to a string
      if(batteryReturn != null){
        String storedFiles = DatatypeConverter.printHexBinary(batteryReturn);
        storedFiles = storedFiles.replaceAll("..", "$0 ");
        println();
        println(storedFiles);
        TableRow row = table.addRow();
        row.setString("Battery Status", storedFiles);
        row.setString("Time", str(hour) + ":" + str(min) + ":" + str(s));
        row.setString("Date", str(month) + "/" + str(day) + "/" + str(year));
        saveTable(table, filename);
        println("Battery status logged, check sketchbook");
      }
      delay(1000);
    }
  }
} */
public class ChannelSetting {
  
  //variables to store stim and recharge subchannels
  private SubChannelSetting stimSetting;
  private SubChannelSetting rchrgSetting;
  
  //a constructor that instantiates stim and recharge subchannels
  public ChannelSetting() {
    stimSetting = new SubChannelSetting();
    rchrgSetting = new SubChannelSetting();
  }
  
  //a method to set the sink/source setting and amplitude intensity of the stim waveform
  public void setStimSetting(boolean sink, int intensity) {
    
    //set the sink/source setting
    stimSetting.setSink(sink);
    
    //set the intensity of the amplitude
    stimSetting.setIntensity(intensity);
  }
  
  //a method to get the sink/source setting and amplitude intensity setting of the stim waveform
  public SubChannelSetting getStimSetting() {
    return stimSetting;
  }
  
  //a method to set the sink/source setting and amplitude intensity of the recharge waveform
  public void setRchrgSetting(boolean sink, int intensity) {
    
    //set the sink/source setting
    rchrgSetting.setSink(sink);
    
    //set the intensity of the amplitude
    rchrgSetting.setIntensity(intensity);
  }
  
  //a method to get the sink/source setting and amplitude intensity of the recharge waveform
  public SubChannelSetting getRchrgSetting() {
    return rchrgSetting;
  }
  
  //convert the sink/source setting and intensity of the stim waveform into a byte array
  public byte[] stimSettingToBytes() {
    return stimSetting.toBytes();
  }
  
  //convert the sink/source setting and intensity of the recharge waveform into a byte array
  public byte[] rchrgSettingToBytes() {
    return rchrgSetting.toBytes();
  }
}
public class SubChannelSetting {
  
  //variables to set minimum intensity, maximum intensity, byte to set stim/recharge as sink, byte to set stim/recharge as source
  private static final int MIN_INTENSITY = 0;
  private static final int MAX_INTENSITY = 60;
  private static final byte SOURCE_BYTE = 0x10;
  private static final byte SINK_BYTE = 0x11;
  
  private boolean sink;
  private int intensity;
  
  //a constructor that sets sink/source to source and intensity to 0
  public SubChannelSetting() {
    this(false, 0);
  }
  
  //a constructor that allows the user to determine sink/source and intensity of stimulus
  public SubChannelSetting(boolean sink, int intensity) {
    setSink(sink);
    setIntensity(intensity);
  }
  
  //a method that can be used to determine if the stimulus is a sink or a source
  public void setSink(boolean sink) {
    this.sink = sink;
  }
  
  //a method that can be used to determine the intensity of the stimulus
  public void setIntensity(int intensity) {
    
    //if the intensity is not within an acceptable range
    if (intensity < MIN_INTENSITY || intensity > MAX_INTENSITY) {
      
      //set the intensity to zero
      this.intensity = 0;
      
      //and inform the user that they did not input a valid integer
      System.out.println("Error: please choose an amplitude between 0 and 60 mA");
      
      //if the intensity is within an acceptable range
    } else {
      
      //set the intensity to the user's input
      this.intensity = intensity;
    }
  }
  
  //a method to retrieve the sink/source setting
  public boolean getSink() {
    return sink;
  }
  
  //a method to retrieve the current amplitude intensity setting
  public int getIntensity() {
    return intensity;
  }
  
  //a method to retrieve the current amplitude intensity setting as a byte
  private byte getIntensityAsByte() {
    
    if (intensity == 0) {
      return 0;
      
      //if the intensity is not 0
    } else {
      
      // Store the percentage of maximum intensity, which is found using the function from linear regression of experimental results
      double percent = (1.12f * intensity + 3.35f);
      
      // Convert from percent to a hex value
      byte hex = (byte) (percent * 255 / 100);
      
      // Return the byte
      
      return hex;
    }
  }
  
  //a method to retrieve the current sink/source setting as a byte
  private byte getSinkAsByte() {
    if (sink) {
      
      //return the byte value that represents a sink setting
      return SINK_BYTE;
      
      //if the sink/source setting is false (represents source)
    } else {
      
      //return the byte value that represents a source setting
      return SOURCE_BYTE;
    }
  }
  
  //a method to store the sink/source setting and the intensity setting as a byte array
  public byte[] toBytes() {
    return new byte[]{getSinkAsByte(), getIntensityAsByte()};
  }
}
class TimingCommand {  
  
  private double duration;
  
  //a byte array to store the timing setting hexadecimal
  private byte[] timingOutput = new byte[11];
  
  //a method that can be used in GUIProject to send the byte to the correct port
  public void sendToSerialPort(Serial thePort){
    thePort.write(timingOutput);
  }
  
  // convert reasonable user input for stimulation pulse width to bytes
  public void setStimPulseWidth(int stimPulseWidth){
    
    //if the number inputed by the user is within an acceptable range
    if(stimPulseWidth > 0 && stimPulseWidth < 300){
      
      byte stimPulseWidthByte = (byte) stimPulseWidth;
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[5] = stimPulseWidthByte;
      
      //tell the user
      println("Stimulus pulse width set to " + stimPulseWidth);
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[5] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for pulse width, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for interpulse delay to bytes
  public void setInterpulseDelay(int interpulseDelay){
    
    //if the number inputed by the user is in an acceptable range
    if(interpulseDelay > 0 && interpulseDelay < 255){
      
      //convert the input to a byte
      byte interpulseDelayByte = (byte) interpulseDelay;
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[6] = interpulseDelayByte;
      
      //tell the user
      println("Interpulse delay set to " + interpulseDelay);
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[6] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for interpulse delay, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for recharge pulse width to bytes
  public void setRechargePulseWidth(int rechargePW){
    
    //if the number inputed by the user is in an acceptable range
    if(rechargePW > 0 && rechargePW < 255){
      
      //Use conversion factors found using characterization chart
      byte rchrgPulseWidthByte = (byte)(rechargePW);
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[7] = rchrgPulseWidthByte;
      
      //tell the user
      println("Recharge pulse width set to " + rechargePW);
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[7] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for recharge pulse width, please choose a value between 0 and 255");
    }
  }
  
  //a class to get the timingOuput array, which will be used to instantiate the sections of the array that are not determined by the user
  public byte[] getTimingOutput(){
    return timingOutput;
  }
  
  public void printTimingOutput(){
    for(int i = 0; i < timingOutput.length; i++){
      print(timingOutput[i] + ", ");
    }
  }
  
  // convert reasonable user input for recharge pulse width to bytes
  public void setPulsePeriod(double pulsePeriod){
    
    //if the number inputed by the user is in an acceptable range
    if(pulsePeriod > 0 && pulsePeriod < 255){
      
      byte pulsePeriodByte = (byte) (pulsePeriod);
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[8] = pulsePeriodByte;
      
      //tell the user
      println("Pulse period set to " + pulsePeriod);
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[8] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for pulse period, please choose a value between 0 and 255");
      println(pulsePeriod);
    }
  }
  
  public void setDuration(double duration){
    this.duration = duration;
    println("Successfully set duration to " + duration + " minutes");
  }
  
  public double getDuration(){
    return this.duration;
  }
}
  
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GUIProject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
