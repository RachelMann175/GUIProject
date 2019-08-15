import controlP5.*;

//BatteryLogging batteryThread;
ControlP5 cp5;
String textValue = "";
String time = "";

public void settings() {
  size(700,1600);
}

void draw() {
}
  


void setup(){
  
  //batteryThread = new BatteryLogging();
  //batteryThread.start();
  noLoop();
  cp5 = new ControlP5(this);
  background(0);
  
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
  
  cp5.addBang("OpenAdvancedSettings")
  .setPosition(20,610)
  .setSize(400,40)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
}

void keyPressed(){
  String[] args = {"AdvancedSettings"};
  AdvancedSettings window = new AdvancedSettings();
  PApplet.runSketch(args, window);
}

void controlEvent(ControlEvent theEvent){
  if(theEvent.getName() == "AdvancedSettings"){
    String[] args = {"Opening advanced settings"};
    AdvancedSettings window = new AdvancedSettings();
    PApplet.runSketch(args, window);
  }
}




  
  






     
     
     


     
