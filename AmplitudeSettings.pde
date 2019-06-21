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
    port.write(START_BYTES);
    
    for (ChannelSetting setting : channelSettings) {
      port.write(setting.stimSettingToBytes());
    }
    
    for (ChannelSetting setting : channelSettings) {
      port.write(setting.rchrgSettingToBytes());
    }
    
    port.write(END_BYTES);
  }
}
