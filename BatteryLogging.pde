/* public class BatteryLogging extends PApplet {
  
  void setup(){
    Serial thePort = new Serial(this, Serial.list()[0], 115200);
  }
  
  public void run() {
    int day = day();
    int month = month();
    int year = year();
    int hour = hour();
    int min = minute();
    int s = second();
      
    //if the port is available
    while(thePort.available() > 0) {
      //A byte to command the board to send the data
      byte[] batteryByte;
      batteryByte = new byte[] {0x00, (byte) 0x80, 0x02, 0x01, 0x01, 0x00, (byte) 0xC0};
  
      //write the battery byte to the port
      thePort.write(batteryByte);
  
      //collect the return byte array from the board
      batteryReturn = thePort.readBytes();
      thePort.readBytes(batteryReturn);
  
      //convert the byte array to a string
      if(batteryReturn != null){
        String storedFiles = DatatypeConverter.printHexBinary(batteryReturn);
        storedFiles = storedFiles.replaceAll("..", "$0 ");
        println();
        println(storedFiles);
        TableRow row = table.addRow();
        row.setString("Battery Status", storedFiles);
        row.setString("Time", str(hour) + ":" + str(min) + ":" + str(s));
        row.setString("Date", str(month) + "/" + str(day) + "/" + str(year));
        saveTable(table, filename);
        println("Battery status logged, check sketchbook");
      }
    }
  }
}*/
