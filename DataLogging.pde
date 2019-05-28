public class DataLogging {
  
  private int storedFiles;
  
  public void GetHistory(){
    byte[] framByte = new byte[]{0x00, (byte) 0x80, 0x09, 0x03, (byte) 0xFF, (byte) 0xC0};
    thePort.write(framByte);
    if(thePort.available() > 0){
      storedFiles = thePort.read();
      
    }
    System.out.println(storedFiles);
    
  }

  public void ClearPulseTimings() {
    cp5.get(Textfield.class,"Stim PW (us)").clear();
    cp5.get(Textfield.class,"Interpulse Delay (us)").clear();
    cp5.get(Textfield.class,"Recharge PW (us)").clear();
    cp5.get(Textfield.class,"Pulse Period (ms)").clear();
  }

  public void ClearAmplitudes() {
    cp5.get(Textfield.class,"Channel 1 Stim: Sink mA").clear();
    cp5.get(Textfield.class,"Channel 2 Stim: Source mA").clear();
    cp5.get(Textfield.class,"Channel 1 Rchrg: Source mA").clear();
    cp5.get(Textfield.class,"Channel 2 Rchrg: Sink mA").clear();
  }
}
