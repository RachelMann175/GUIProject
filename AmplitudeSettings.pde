public class AmplitudeSettings {
  
  private static final int NUM_CHANNELS = 2;
  
  //byte arrays to store the numbers at the beginning and end of the hexadecimal that will set amplitude
  private final byte[] START_BYTES = {0x00, (byte) 0x80, 0x0B, 0x11, 0x01};
  private final byte[] END_BYTES = {0x00, 0x00, 0x00, 0x00, 0x00};
  private final byte[] INTERMEDIATE = {0x00, 0x00, 0x00, 0x00};
  
  //an array to store stim vs recharge settings
  private ChannelSetting[] channelSettings;
  
  //a constructor to instantiate an array of the four possible channels
  public AmplitudeSettings() {
    channelSettings = new ChannelSetting[NUM_CHANNELS];
    for (int i = 0; i < NUM_CHANNELS; i++) {
      channelSettings[i] = new ChannelSetting();
    }
  }
  
  //a method to set the sink/source settings and intensity of the specified channel for the stim waveform
  public void setStimSetting(int channel, boolean sink, int intensity) {
    
    // sets stim setting and sends it to the board
    try {
      
      //set the sink/source and intensity of the specified channel 
      channelSettings[channel - 1].setStimSetting(sink, intensity);
      
      //store the current sink/source setting and amplitude intensity of the specified channel
      SubChannelSetting newSettings = channelSettings[channel - 1].getStimSetting();
      
      //inform the user of the current settings
      println("Successfully set channel " + channel + " stim to " + (newSettings.getSink() ? "sink " : "source ") + newSettings.getIntensity() + " mA");
      
    } catch (ArrayIndexOutOfBoundsException e) {
      println(e);
    }
  }
  
  public void setRchrgSetting(int channel, boolean sink, int intensity) {
    // sets rchrg setting and sends it to the board
    try {
      channelSettings[channel - 1].setRchrgSetting(sink, intensity);
      SubChannelSetting newSettings = channelSettings[channel - 1].getRchrgSetting();
      println("Successfully set channel " + channel + " rchrg to " + (newSettings.getSink() ? "sink " : "source ") + newSettings.getIntensity() + " mA");
    } catch (ArrayIndexOutOfBoundsException e) {
      println(e);
    }
  }
  
  public void sendSettingsToBoard(Serial port) {
    
    //Two byte arrays for stim settings and recharge settings
    byte[] STIM_SET_BYTES_1 = new byte[2];
    byte[] STIM_SET_BYTES_2 = new byte[2];
    byte[] RCHRG_SET_BYTES_1 = new byte[2];
    byte[] RCHRG_SET_BYTES_2 = new byte[2];
      
    //send the proper hexadecimal to the stim set byte array for channel 1
    STIM_SET_BYTES_1 = channelSettings[0].stimSettingToBytes();
      
    //and send the proper hexadecimal to the recharge set byte array for channel 1
    RCHRG_SET_BYTES_1 = channelSettings[0].rchrgSettingToBytes();
    
    //send the proper hexadecimal to the stim set byte array for channel 2
    STIM_SET_BYTES_2 = channelSettings[1].stimSettingToBytes();
    
    //send the proper hexadecimal to the recharage set byte array for channel 2
    RCHRG_SET_BYTES_2 = channelSettings[1].rchrgSettingToBytes();
    
    //copy the start byte array, setting byte arrays, and end byte array to one amplitudeArray to be sent to the port
    byte[] amplitudeArray = new byte[START_BYTES.length + STIM_SET_BYTES_1.length + RCHRG_SET_BYTES_1.length + STIM_SET_BYTES_2.length + RCHRG_SET_BYTES_2.length +INTERMEDIATE.length + END_BYTES.length];
    
    //copty the start byte array
    System.arraycopy(START_BYTES, 0, amplitudeArray, 0, START_BYTES.length);
    
    //copy the stim channel 1 byte array
    System.arraycopy(STIM_SET_BYTES_1, 0, amplitudeArray, START_BYTES.length, STIM_SET_BYTES_1.length);
    
    //copy the stim channel 2 byte array
    System.arraycopy(STIM_SET_BYTES_2, 0, amplitudeArray, START_BYTES.length 
                                                        + STIM_SET_BYTES_1.length, STIM_SET_BYTES_2.length);
                                                   
    //copy the intermediate byte array                                                    
    System.arraycopy(INTERMEDIATE, 0, amplitudeArray, START_BYTES.length 
                                                    + STIM_SET_BYTES_1.length 
                                                    + STIM_SET_BYTES_2.length, INTERMEDIATE.length);
    
    //copy the recharge channel 1 byte array
    System.arraycopy(RCHRG_SET_BYTES_1, 0, amplitudeArray, START_BYTES.length 
                                                         + STIM_SET_BYTES_1.length 
                                                         + STIM_SET_BYTES_2.length 
                                                         + INTERMEDIATE.length, RCHRG_SET_BYTES_1.length);
    
    //copy the recharge channel 2 byte array                                                     
    System.arraycopy(RCHRG_SET_BYTES_2, 0, amplitudeArray, START_BYTES.length 
                                                         + STIM_SET_BYTES_1.length 
                                                         + STIM_SET_BYTES_2.length 
                                                         + INTERMEDIATE.length 
                                                         + RCHRG_SET_BYTES_1.length, RCHRG_SET_BYTES_2.length);
    
    //copy the ending byte array                                                     
    System.arraycopy(END_BYTES, 0, amplitudeArray, START_BYTES.length 
                                                 + STIM_SET_BYTES_1.length 
                                                 + STIM_SET_BYTES_2.length 
                                                 + INTERMEDIATE.length 
                                                 + RCHRG_SET_BYTES_1.length 
                                                 + RCHRG_SET_BYTES_2.length, END_BYTES.length);
    
    //send the final array to the port
    port.write(amplitudeArray);
    
    
    println();
    println("Amplitude array");
    for(int i = 0; i < amplitudeArray.length; i++){
      print(amplitudeArray[i] + ", ");
    }
  }
}
