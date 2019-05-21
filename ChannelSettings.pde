public class ChannelSetting {
  private SubChannelSetting stimSetting;
  private SubChannelSetting rchrgSetting;
  
  public ChannelSetting() {
    stimSetting = new SubChannelSetting();
    rchrgSetting = new SubChannelSetting();
  }
  
  public void setStimSetting(boolean sink, int intensity) {
    stimSetting.setSink(sink);
    stimSetting.setIntensity(intensity);
  }
  
  public SubChannelSetting getStimSetting() {
    return stimSetting;
  }
  
  public void setRchrgSetting(boolean sink, int intensity) {
    rchrgSetting.setSink(sink);
    rchrgSetting.setIntensity(intensity);
  }
  
  public SubChannelSetting getRchrgSetting() {
    return rchrgSetting;
  }
  
  public byte[] stimSettingToBytes() {
    return stimSetting.toBytes();
  }
  
  public byte[] rchrgSettingToBytes() {
    return rchrgSetting.toBytes();
  }
}
