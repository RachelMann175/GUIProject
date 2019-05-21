import controlP5.*;
import processing.serial.*;
import java.util.List;
import java.util.Arrays;

String textValue = "";
ControlP5 cp5;
Serial thePort;
TimingCommand tc = new TimingCommand();
AmplitudeSettings amplitudes = new AmplitudeSettings();

List<Textfield> amplitudeInputs;
List<Textfield> timingInputs;
List<Label> buttons;

private ArrayList<Integer> channel1StimSinkInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel1StimSourceInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel2StimSinkInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel2StimSourceInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel1RchrgSinkInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel1RchrgSourceInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel2RchrgSinkInfo = new ArrayList<Integer>();
private ArrayList<Integer> channel2RchrgSourceInfo = new ArrayList<Integer>();

void setup() {
  
  size(700,1600);
  PFont font = createFont("Arial", 20);
  
  cp5 = new ControlP5(this);
  
    timingInputs = Arrays.asList(
    cp5.addTextfield("Stim PW (us)")
    .setPosition(20,50)
    .setSize(200,40)
    .setFont(font)
    .setAutoClear(false),
  
    cp5.addTextfield("Interpulse Delay (us)")
    .setPosition(20,120)
    .setSize(200,40)
    .setFont(font)
    .setAutoClear(false),
    
    cp5.addTextfield("Recharge PW (us)")
    .setPosition(20,190)
    .setSize(200,40)
    .setFont(font)
    .setAutoClear(false),
    
    cp5.addTextfield("Pulse Period (ms)")
    .setPosition(20,260)
    .setSize(200,40)
    .setFont(font)
    .setAutoClear(false)
    );
  
   amplitudeInputs = Arrays.asList(
   cp5.addTextfield("Channel 1 Stim: Sink mA")
  .setPosition(20,330)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 1 Stim: Source mA")
  .setPosition(20,400)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 1 Rchrg: Sink mA")
  .setPosition(20,470)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 1 Rchrg: Source mA")
  .setPosition(20,540)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 2 Stim: Source mA")
  .setPosition(20,610)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 2 Stim: Sink mA")
  .setPosition(20,680)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 2 Rchrg: Sink mA")
  .setPosition(20,750)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false),
  
  cp5.addTextfield("Channel 2 Rchrg: Source mA")
  .setPosition(20,820)
  .setSize(200,40)
  .setFont(font)
  .setAutoClear(false)
  );
  
  
  buttons = Arrays.asList(
  cp5.addBang("ClearPulseTimings")
  .setPosition(240,50)
  .setSize(80, 40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("ClearAmplitudes")
  .setPosition(240,330)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("startStim")
  .setPosition(20,890)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("Buzzer")
  .setPosition(480,50)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("StopBuzzer")
  .setPosition(600,50)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetStimPWInformation")
  .setPosition(360,50)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetInterpulseDelayInformation")
  .setPosition(360,120)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetRechargePWInformation")
  .setPosition(360,190)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetPulsePeriodInformation")
  .setPosition(360,260)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel1StimSinkInfo")
  .setPosition(360,330)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel1StimSourceInfo")
  .setPosition(360,400)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel2StimSinkInfo")
  .setPosition(360,470)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel2StimSourceInfo")
  .setPosition(360,540)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel1RchrgSinkInfo")
  .setPosition(360,610)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel1RchrgSourceInfo")
  .setPosition(360,680)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel2RchrgSinkInfo")
  .setPosition(360,750)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER),
  
  cp5.addBang("GetChannel2RchrgSourceInfo")
  .setPosition(360,820)
  .setSize(80,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  );
  
  textFont(font);
  
  int baudRate = 115200;
  String portName = Serial.list()[0];
  thePort = new Serial(this, portName, baudRate);
  
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

    
void controlEvent(ControlEvent theEvent){
  
  int intensity;
  
  if(amplitudeInputs.contains(theEvent.getController()) || timingInputs.contains(theEvent.getController())){
    try {
      
      intensity = Integer.parseInt(theEvent.getStringValue());
      
      switch(theEvent.getName()){
    
        case "Channel 1 Stim: Sink mA":
          amplitudes.setStimSetting(1, true, intensity);
          channel1StimSinkInfo.add(intensity);
          break;
    
        case "Channel 1 Stim: Source mA":
          amplitudes.setStimSetting(1, false, intensity);
          channel1StimSourceInfo.add(intensity);
          break;
    
        case "Channel 2 Stim: Sink mA":
          amplitudes.setStimSetting(2, true, intensity);
          channel2StimSinkInfo.add(intensity);
          break;
    
        case "Channel 2 Stim: Source mA":
          amplitudes.setStimSetting(2, false, intensity);
          channel2StimSourceInfo.add(intensity);
          break;
      
        case "Channel 1 Rchrg: Sink mA":
          amplitudes.setRchrgSetting(1, true, intensity);
          channel1RchrgSinkInfo.add(intensity);
          break;
    
        case "Channel 1 Rchrg: Source mA":
          amplitudes.setRchrgSetting(1, false, intensity);
          channel1RchrgSourceInfo.add(intensity);
          break;
      
        case "Channel 2 Rchrg: Sink mA":
          amplitudes.setRchrgSetting(2, true, intensity);
          channel2RchrgSinkInfo.add(intensity);
          break;
    
        case "Channel 2 Rchrg: Source mA":
          amplitudes.setRchrgSetting(2, false, intensity);
          channel2RchrgSourceInfo.add(intensity);
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
  
  // write the timing hexidecimals to the serial port
  tc.sendToSerialPort(thePort);
}

public void input(String theText){
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : " + theText);
  
}





  
  






     
     
     


     
