public class SubChannelSetting {
  
  //variables to set minimum intensity, maximum intensity, byte to set stim/recharge as sink, byte to set stim/recharge as source
  private static final int MIN_INTENSITY = 0;
  private static final int MAX_INTENSITY = 60;
  private static final byte SOURCE_BYTE = 0x10;
  private static final byte SINK_BYTE = 0x11;
  
  private boolean sink;
  private int intensity;
  
  //a constructor that sets sink/source to source and intensity to 0
  public SubChannelSetting() {
    this(false, 0);
  }
  
  //a constructor that allows the user to determine sink/source and intensity of stimulus
  public SubChannelSetting(boolean sink, int intensity) {
    setSink(sink);
    setIntensity(intensity);
  }
  
  //a method that can be used to determine if the stimulus is a sink or a source
  public void setSink(boolean sink) {
    this.sink = sink;
  }
  
  //a method that can be used to determine the intensity of the stimulus
  public void setIntensity(int intensity) {
    
    //if the intensity is not within an acceptable range
    if (intensity < MIN_INTENSITY || intensity > MAX_INTENSITY) {
      
      //set the intensity to zero
      this.intensity = 0;
      
      //and inform the user that they did not input a valid integer
      System.out.println("Error: please choose an amplitude between 0 and 60 mA");
      
      //if the intensity is within an acceptable range
    } else {
      
      //set the intensity to 
      this.intensity = intensity;
    }
  }
  
  public boolean getSink() {
    return sink;
  }
  
  public int getIntensity() {
    return intensity;
  }
  
  private byte getIntensityAsByte() {
    if (intensity == 0) {
      return 0;
    } else {
      // Function from linear regression of experimental results
      double percent = (1.12 * intensity + 3.35);
      
      // Convert from percent to a hex value
      byte hex = (byte) (percent * 255 / 100);
      return hex;
    }
  }
  
  private byte getSinkAsByte() {
    if (intensity == 0) {
      return 0;
    } else if (sink) {
      return SINK_BYTE;
    } else {
      return SOURCE_BYTE;
    }
  }
  
  public byte[] toBytes() {
    return new byte[]{getSinkAsByte(), getIntensityAsByte()};
  }
}
