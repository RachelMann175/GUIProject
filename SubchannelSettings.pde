public class SubChannelSetting {
  private static final int MIN_INTENSITY = 0;
  private static final int MAX_INTENSITY = 60;
  private static final byte SOURCE_BYTE = 0x10;
  private static final byte SINK_BYTE = 0x11;
  
  private boolean sink;
  private int intensity;
  
  public SubChannelSetting() {
    this(false, 0);
  }
  
  public SubChannelSetting(boolean sink, int intensity) {
    setSink(sink);
    setIntensity(intensity);
  }
  
  public void setSink(boolean sink) {
    this.sink = sink;
  }
  
  public void setIntensity(int intensity) {
    if (intensity < MIN_INTENSITY || intensity > MAX_INTENSITY) {
      this.intensity = 0;
      System.out.println("Error: please choose an amplitude between 0 and 60 mA");
    } else {
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
