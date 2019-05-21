public class AmplitudeSettings {
  private static final int NUM_CHANNELS = 4;
  private final byte[] START_BYTES = {0x00, (byte) 0x80, 0x0B, 0x11, 0x01};
  private final byte[] END_BYTES = {0x00, (byte) 0xC0};
  
  private ChannelSetting[] channelSettings;
  
  public AmplitudeSettings() {
    channelSettings = new ChannelSetting[NUM_CHANNELS];
    for (int i = 0; i < NUM_CHANNELS; i++) {
      channelSettings[i] = new ChannelSetting();
    }
  }
  
  public void setStimSetting(int channel, boolean sink, int intensity) {
    // sets stim setting and sends it to the board
    try {
      channelSettings[channel - 1].setStimSetting(sink, intensity);
      SubChannelSetting newSettings = channelSettings[channel - 1].getStimSetting();
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
