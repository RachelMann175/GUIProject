public void settings() {
  size(700,1600);
}

void setup(){
  noLoop();
  background(0);
}

void keyPressed() {
  String[] args = {"Opening advanced settings"};
  AdvancedSettings window = new AdvancedSettings();
  PApplet.runSketch(args, window);
}
