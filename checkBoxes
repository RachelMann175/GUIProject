class CheckBoxSettings{
  
  private boolean stimSet1;
  private boolean stimSet2;
  private boolean rchrgSet1;
  private boolean rchrgSet2;
  
  void controlEvent(ControlEvent theEvent){
    
    if(checkBoxes.contains(theEvent.getName())){
        switch(theEvent.getName()){
          case "Channel 1 Stim: Sink":
            stimSet1 = true;
            break;
        
          case "Channel 1 Stim: Source":
            stimSet1 = false;
            break;
        
          case "Channel 2 Stim: Sink":
            stimSet2 = true;
            break;
        
          case "Channel 2 Stim: Source":
            stimSet2 = false;
            break;
      
          case "Channel 1 Rchrg: Sink":
            rchrgSet1 = true;
            break;
        
          case "Channel 1 Rchrg: Source":
            rchrgSet1 = false;
            break;
        
          case "Channel 2 Rchrg: Sink":
            rchrgSet2 = true;
            break;
        
          case "Channel 2 Rchrg: Source":
            rchrgSet2 = false;
            break;
        }
      }
    }
  
  
  public boolean getStimSet1(){
    return stimSet1;
  }
  
  public boolean getStimSet2(){
    return stimSet2;
  }
  
  public boolean getRchrgSet1(){
    return rchrgSet1;
  }
  
  public boolean getRchrgSet2(){
    return rchrgSet2;
  }
}
