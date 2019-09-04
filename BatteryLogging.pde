/*public class BatteryLogging extends PApplet {
  
  Serial myPort;
  
  void setup(){
    myPort = new Serial(this, Serial.list()[1], 115200);
  }
  
  public void run() {
    int day = day();
    int month = month();
    int year = year();
    int hour = hour();
    int min = minute();
    int s = second();
    
    delay(200);
      
    //if the port is available
    while(myPort.available() > 0) {
      //A byte to command the board to send the data
      byte[] batteryByte;
      batteryByte = new byte[] {0x00, (byte) 0x80, 0x02, 0x01, 0x01, 0x00, (byte) 0xC0};
  
      //write the battery byte to the port
      myPort.write(batteryByte);
  
      //collect the return byte array from the board
      batteryReturn = myPort.readBytes();
      myPort.readBytes(batteryReturn);
  
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
      delay(1000);
    }
  }
} */
