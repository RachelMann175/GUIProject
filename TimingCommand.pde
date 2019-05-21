class TimingCommand {
  
    private byte[] timingOutput = {(byte) 0x00, (byte) 0x80, (byte) 0x0B, (byte) 0x05, (byte) 0x02,
                           (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0xC0};
    private ArrayList<Integer> stimPWInformation = new ArrayList<Integer>();
    private ArrayList<Integer> interpulseDelayInformation = new ArrayList<Integer>();
    private ArrayList<Integer> rechargePulseWidthInformation = new ArrayList<Integer>();
    private ArrayList<Integer> pulsePeriodInformation = new ArrayList<Integer>();
 
  public void sendToSerialPort(Serial thePort){
    thePort.write(timingOutput);
  }
  
  // convert reasonable user input for stimulation pulse width to bytes
  public void setStimPulseWidth(int stimPulseWidth){
    if(stimPulseWidth > 0 && stimPulseWidth < 256){
      byte stimPulseWidthByte = (byte) stimPulseWidth;
      timingOutput[5] = stimPulseWidthByte;
      stimPWInformation.add(stimPulseWidth); //update data log
    }
    else{
      timingOutput[5] = (byte) 0x00;
      println("error: invalid integer for pulse width, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for interpulse delay to bytes
  public void setInterpulseDelay(int interpulseDelay){
    if(interpulseDelay > 0 && interpulseDelay < 255){
      byte interpulseDelayByte = (byte) interpulseDelay;
      timingOutput[6] = interpulseDelayByte;
      interpulseDelayInformation.add(interpulseDelay); //update data log
    }
    else{
      timingOutput[6] = (byte) 0x00;
      println("error: invalid integer for interpulse delay, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for recharge pulse width to bytes
  public void setRechargePulseWidth(int rechargePW){
    if(rechargePW > 0 && rechargePW < 255){
      byte rchrgPulseWidthByte = (byte) rechargePW;
      timingOutput[7] = rchrgPulseWidthByte;
      rechargePulseWidthInformation.add(rechargePW); //update data log
    }
    else{
      timingOutput[7] = (byte) 0x00;
      println("error: invalid integer for recharge pulse width, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for recharge pulse width to bytes
  public void setPulsePeriod(int pulsePeriod){
    if(pulsePeriod > 0 && pulsePeriod < 255){
      byte pulsePeriodByte = (byte) pulsePeriod;
      timingOutput[8] = pulsePeriodByte;
      pulsePeriodInformation.add(pulsePeriod); //update data log
    }
    else{
      timingOutput[8] = (byte) 0x00;
      println("error: invalid integer for pulse period, please choose a value between 0 and 255");
    }
  }
  
  public ArrayList<Integer> getStimPWInformation(){
    return stimPWInformation;
  }
  
  public ArrayList<Integer> getInterpulseDelayInformation(){
    return interpulseDelayInformation;
  }
  
  public ArrayList<Integer> getRechargePulseWidthInformation(){
    return rechargePulseWidthInformation;
  }
  
  public ArrayList<Integer> getPulsePeriodInformation(){
    return pulsePeriodInformation;
  }
}
  
