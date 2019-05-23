import controlP5.*;
import processing.serial.*;
import java.util.List;
import java.util.Arrays;

String textValue = "";
ControlP5 cp5;
Serial thePort;
TimingCommand tc = new TimingCommand();
AmplitudeSettings amplitudes = new AmplitudeSettings();
CheckBoxSettings checkBoxSet = new CheckBoxSettings();

List<String> amplitudeInputs;
List<String> timingInputs;
List<String> buttons;
List<String> checkBoxes;

void setup() {
  
  size(700,1600);
  PFont font = createFont("Arial", 20);
  
  cp5 = new ControlP5(this);
  
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
    
   amplitudeInputs = Arrays.asList("Channel 1 Stim: mA", "Channel 1 Rchrg: mA",
                                   "Channel 2 Stim: mA", "Channel 2 Rchrg: mA");
                                   
   cp5.addTextfield("Channel 1 Stim: mA")
  .setPosition(20,330)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addTextfield("Channel 1 Rchrg: mA")
  .setPosition(20,470)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addTextfield("Channel 2 Stim: mA")
  .setPosition(20,610)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
  cp5.addTextfield("Channel 2 Rchrg: mA")
  .setPosition(20,750)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false);
  
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
  
  buttons = Arrays.asList("ClearPulseTimings", "ClearAmplitudes", "startStim",
                          "setTiming", "setAmplitude", "Buzzer", "StopBuzzer",
                          "GetHistory");
                          
  cp5.addBang("ClearPulseTimings")
  .setPosition(240,50)
  .setSize(80, 40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("ClearAmplitudes")
  .setPosition(240,330)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("startStim")
  .setPosition(20,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("setTiming")
  .setPosition(120,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("setAmplitude")
  .setPosition(220,890)
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
  
  textFont(font);
  
  int baudRate = 115200;
  //String portName = Serial.list()[0];
  //thePort = new Serial(this, portName, baudRate);
  
  background(0);
  fill(255);
}

void draw(){
}


public void Buzzer(){
  
  // a byte array to store the hexidecimals that will cause a buzz
  byte[] buzz;
  buzz = new byte[] { (byte) 0x00, (byte) 0x80, (byte) 0x05, (byte) 0x01, 
                      (byte) 0x01, (byte) 0x00, (byte) 0xC0};
  println("Buzzing");
  thePort.write(buzz);
}

public void StopBuzzer(){
  
  byte[] stopBuzz = { (byte) 0x00, (byte) 0x80, (byte) 0x05, (byte) 0x01, 
                      (byte) 0x00, (byte) 0x00, (byte) 0xC0};
  thePort.write(stopBuzz);
}

public void startStim() {
 
  // a byte array to store the hexidecimals that will be start the stimulation
  byte[] startingStim;
  startingStim = new byte[] { (byte) 0x00, (byte) 0x80, (byte) 0x0B, (byte) 0x01, 
                  (byte) 0x03, (byte) 0x00, (byte) 0xC0 };
  
  println("Starting Stim : " + startingStim);
  thePort.write(startingStim);
}

public void setTiming(){
  println("Setting timing");
  tc.sendToSerialPort(thePort);
}

public void setAmplitude(){
  println("Setting amplitude");
  amplitudes.sendSettingsToBoard(thePort);
} 

 
void controlEvent(ControlEvent theEvent){
  
  int intensity;
  
  if(amplitudeInputs.contains(theEvent.getName()) || timingInputs.contains(theEvent.getName())){
    try {  
      
      intensity = Integer.parseInt(theEvent.getStringValue());
      
      switch(theEvent.getName()){
    
        case "Channel 1 Stim: mA":
          amplitudes.setStimSetting(1, checkBoxSet.getStimSet1(), intensity);
          channel1StimSinkInfo.add(intensity);
          break;
    
        case "Channel 2 Stim: Sink mA":
          amplitudes.setStimSetting(2, checkBoxSet.getStimSet2(), intensity);
          channel2StimSinkInfo.add(intensity);
          break;
      
        case "Channel 1 Rchrg: mA":
          amplitudes.setRchrgSetting(1, checkBoxSet.getRchrgSet1(), intensity);
          channel1RchrgSinkInfo.add(intensity);
          break;
      
        case "Channel 2 Rchrg: mA":
          amplitudes.setRchrgSetting(2, checkBoxSet.getRchrgSet2(), intensity);
          channel2RchrgSinkInfo.add(intensity);
          break;
  
        // if user is setting stimulus pulse width, store the input as a byte
        case "Stim PW (us)":
          tc.setStimPulseWidth(Integer.parseInt(theEvent.getStringValue()));
          break;
  
        // if user is setting interpulse delay, store the input as a byte
        case "Interpulse Delay (us)":
          tc.setInterpulseDelay(Integer.parseInt(theEvent.getStringValue()));
          break;
  
        // if user is setting recharge pulse width, store the input as a byte
        case "Recharge PW (us)":
          tc.setRechargePulseWidth(Integer.parseInt(theEvent.getStringValue()));
          break;
  
        // if user is setting pulse period, store the input as a byte
        case "Pulse Period (ms)":
          tc.setPulsePeriod(Integer.parseInt(theEvent.getStringValue()));
          break;
      }
    
      
      
    } catch (NumberFormatException e) {
      println("Error: Must enter valid integer input!");
    }
  }
}





  
  






     
     
     


     
