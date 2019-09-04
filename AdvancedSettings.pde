import processing.serial.*;
import java.util.List;
import java.util.Arrays;
import java.io.File;
import javax.xml.bind.DatatypeConverter;
import java.util.Scanner;
import java.io.FileNotFoundException;

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

void setup() {
  
  PFont font = createFont("Arial", 20);
  
  cp5 = new ControlP5(this);
  
  //Adding Data, Time, Date columns to the table
  table.addColumn("Data");
  table.addColumn("Time");
  table.addColumn("Date");
  
  //Adding the timing setting event names to the timingInputs list
  timingInputs = Arrays.asList("Stim PW (us)", "Interpulse Delay (us)",
                                 "Recharge PW (us)", "Pulse Period (ms)");
  
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

void draw(){
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
public void turnOnLEDs(){
  
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
  tc.sendToSerialPort(thePort);
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
    storedFiles = storedFiles.replaceAll("..", "$0 ");
    println();
    println("Battery status is: ");
    println(storedFiles);
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
void controlEvent(ControlEvent theEvent){

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
