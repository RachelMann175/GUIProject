public class ChannelSetting {
  
  //variables to store stim and recharge subchannels
  private SubChannelSetting stimSetting;
  private SubChannelSetting rchrgSetting;
  
  //a constructor that instantiates stim and recharge subchannels
  public ChannelSetting() {
    stimSetting = new SubChannelSetting();
    rchrgSetting = new SubChannelSetting();
  }
  
  //a method to set the sink/source setting and amplitude intensity of the stim waveform
  public void setStimSetting(boolean sink, int intensity) {
    
    //set the sink/source setting
    stimSetting.setSink(sink);
    
    //set the intensity of the amplitude
    stimSetting.setIntensity(intensity);
  }
  
  //a method to get the sink/source setting and amplitude intensity setting of the stim waveform
  public SubChannelSetting getStimSetting() {
    return stimSetting;
  }
  
  //a method to set the sink/source setting and amplitude intensity of the recharge waveform
  public void setRchrgSetting(boolean sink, int intensity) {
    
    //set the sink/source setting
    rchrgSetting.setSink(sink);
    
    //set the intensity of the amplitude
    rchrgSetting.setIntensity(intensity);
  }
  
  //a method to get the sink/source setting and amplitude intensity of the recharge waveform
  public SubChannelSetting getRchrgSetting() {
    return rchrgSetting;
  }
  
  //convert the sink/source setting and intensity of the stim waveform into a byte array
  public byte[] stimSettingToBytes() {
    return stimSetting.toBytes();
  }
  
  //convert the sink/source setting and intensity of the recharge waveform into a byte array
  public byte[] rchrgSettingToBytes() {
    return rchrgSetting.toBytes();
  }
}
