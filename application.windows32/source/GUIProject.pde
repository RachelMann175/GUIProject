import controlP5.*;

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

void draw() {
  background(0);
}
  
void setup(){
  
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


void controlEvent(ControlEvent theEvent) throws InterruptedException {
  
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
     
