public class AmplitudeSettings {
  
  private static final int NUM_CHANNELS = 4;
  
  //byte arrays to store the numbers at the beginning and end of the hexadecimal that will set amplitude
  private final byte[] START_BYTES = {0x00, (byte) 0x80, 0x0B, 0x11, 0x01};
  private final byte[] END_BYTES = {0x00, (byte) 0xC0};
  
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
    byte[] STIM_SET_BYTES = new byte[4];
    byte[] RCHRG_SET_BYTES = new byte[4];
    
    //for each setting in the channelSettings array
    for (ChannelSetting setting : channelSettings) {
      
      //send the proper hexadecimal to the stim set byte array
      STIM_SET_BYTES = setting.stimSettingToBytes();
      
      //and send the proper hexadecimal to the recharge set byte array
      RCHRG_SET_BYTES = setting.rchrgSettingToBytes();
    }
    
    byte[] amplitudeArray = new byte[START_BYTES.length + STIM_SET_BYTES.length + RCHRG_SET_BYTES.length + END_BYTES.length];
    System.arraycopy(START_BYTES, 0, amplitudeArray, 0, START_BYTES.length);
    System.arraycopy(STIM_SET_BYTES, 0, amplitudeArray, START_BYTES.length, STIM_SET_BYTES.length);
    System.arraycopy(RCHRG_SET_BYTES, 0, amplitudeArray, STIM_SET_BYTES.length, RCHRG_SET_BYTES.length);
    System.arraycopy(END_BYTES, 0, amplitudeArray, RCHRG_SET_BYTES.length, END_BYTES.length);
    port.write(amplitudeArray);
    for(int i = 0; i < amplitudeArray.length; i++){
      print(amplitudeArray[i] + ", ");
    }
  }
}
