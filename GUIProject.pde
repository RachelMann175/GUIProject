import controlP5.*;

//BatteryLogging batteryThread;
ControlP5 cp5;
AdvancedSettings as;
List<String> simpleSettingEvents;
List<String> simpleButtons;

Serial thePort;
TimingCommand tc = new TimingCommand();
AmplitudeSettings amplitudes = new AmplitudeSettings();

public void settings() {
  size(700,1600);
}

void draw() {
}
  
void setup(){
  
  int baudRate = 115200;
  String portName = Serial.list()[0];
  thePort = new Serial(this, portName, baudRate);
  
  //batteryThread = new BatteryLogging();
  //batteryThread.start();
  cp5 = new ControlP5(this);
  background(0);
  as = new AdvancedSettings();
  
  simpleSettingEvents= Arrays.asList("Amplitude: mA", "Frequency: Hz",
                                   "Pulsewidth: us", "Amplitude Up", "Amplitude Down");
  
  cp5.addTextfield("Amplitude: mA")
  .setPosition(20,50)
  .setSize(200,40)
  .setAutoClear(false);
  
  cp5.addTextfield("Current Amplitude")
  .setPosition(260,50)
  .setSize(200,40)
  .setAutoClear(false);
  
  cp5.addBang("Amplitude Up")
  .setPosition(500,30)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-up-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("Amplitude Down")
  .setPosition(560,30)
  .setImage(loadImage("C://Users//Setup//Documents//GitHub//GUIProject//Small-down-arrow.png"))
  .updateSize()
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addTextfield("Frequency: Hz")
  .setPosition(20,190)
  .setSize(200,40)
  .setAutoClear(false);
  
  cp5.addTextfield("Pulsewidth: us")
  .setPosition(20,330)
  .setSize(200,40)
  .setAutoClear(false);
  
  simpleButtons = Arrays.asList("StartStim", "StopStim", 
                                 "SetAmplitude", "SetTiming");
  
  cp5.addBang("StartStim")
  .setPosition(20,610)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("StopStim")
  .setPosition(260,610)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("SetAmplitude")
  .setPosition(20,470)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("SetTiming")
  .setPosition(260,470)
  .setSize(200,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
  cp5.addBang("OpenAdvancedSettings")
  .setPosition(20,750)
  .setSize(400,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  
}


void controlEvent(ControlEvent theEvent) throws InterruptedException {
  
  //int intensity = Integer.parseInt(theEvent.getStringValue());
  
  if(theEvent.getName() == "OpenAdvancedSettings"){
    String[] args = {"Opening advanced settings"};
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
      
    }
  }
  if(simpleButtons.contains(theEvent.getName())){
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
      
      /*case "Amplitude Up" :
      amplitudes.setStimSetting(1, stimSet1, intensity++);
      amplitudes.setRchrgSetting(1, rchrgSet1, intensity++);
      amplitudes.setStimSetting(2, stimSet2, intensity++);
      amplitudes.setRchrgSetting(2, rchrgSet2, intensity++);
      
      case "Amplitude Down" :
      amplitudes.setStimSetting(1, stimSet1, intensity--);
      amplitudes.setRchrgSetting(1, rchrgSet1, intensity--);
      amplitudes.setStimSetting(2, stimSet2, intensity--);
      amplitudes.setRchrgSetting(2, rchrgSet2, intensity--);
      */
    } 
  }
}




  
  






     
     
     


     
