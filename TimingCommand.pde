class TimingCommand {
  
  //a byte array to store the timing setting hexadecimal
  private byte[] timingOutput = {(byte) 0x00, (byte) 0x80, (byte) 0x0B, (byte) 0x05, (byte) 0x02,
                           (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0xC0};
  
  //a method that can be used in GUIProject to send the byte to the correct port
  public void sendToSerialPort(Serial thePort){
    thePort.write(timingOutput);
  }
  
  // convert reasonable user input for stimulation pulse width to bytes
  public void setStimPulseWidth(int stimPulseWidth){
    
    //if the number inputed by the user is within an acceptable range
    if(stimPulseWidth > 0 && stimPulseWidth < 256){
      
      //convert the input to a byte
      byte stimPulseWidthByte = (byte) stimPulseWidth;
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[5] = stimPulseWidthByte;
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
      
      //convert the input to a byte
      byte rchrgPulseWidthByte = (byte) rechargePW;
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[7] = rchrgPulseWidthByte;
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[7] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for recharge pulse width, please choose a value between 0 and 255");
    }
  }
  
  // convert reasonable user input for recharge pulse width to bytes
  public void setPulsePeriod(int pulsePeriod){
    
    //if the number inputed by the user is in an acceptable range
    if(pulsePeriod > 0 && pulsePeriod < 255){
      
      //convert the input to a byte
      byte pulsePeriodByte = (byte) pulsePeriod;
      
      //send the byte to the correct spot in the hexadecimal
      timingOutput[8] = pulsePeriodByte;
    }
    
    //if the number inputed by the user is not within an acceptable range
    else{
      
      //send 0 to the correct spot in the hexadecimal
      timingOutput[8] = (byte) 0x00;
      
      //inform the user that they did not input a valid integer
      println("error: invalid integer for pulse period, please choose a value between 0 and 255");
    }
  }
}
  
